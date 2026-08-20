from __future__ import annotations

from dataclasses import dataclass

import numpy as np
import torch
from torch import nn


def resolve_torch_device(device_name: str) -> tuple[torch.device, torch.dtype]:
    if device_name == "auto":
        if torch.cuda.is_available():
            device_name = "cuda"
        elif getattr(torch.backends, "mps", None) is not None and torch.backends.mps.is_available():
            device_name = "mps"
        else:
            device_name = "cpu"

    if device_name == "cuda" and not torch.cuda.is_available():
        raise ValueError("Requested device 'cuda', but CUDA is not available.")
    if device_name == "mps":
        mps_backend = getattr(torch.backends, "mps", None)
        if mps_backend is None or not mps_backend.is_available():
            raise ValueError("Requested device 'mps', but MPS is not available.")

    dtype = torch.float32 if device_name == "mps" else torch.float64
    return torch.device(device_name), dtype


@dataclass
class FitResult:
    loss: float
    accuracy: float
    fits_exactly: bool


class TorchAttentionCore(nn.Module):
    def __init__(
        self,
        n_bits: int,
        heads: int,
        d_model: int,
        d_head: int,
        *,
        device: torch.device,
        dtype: torch.dtype,
    ):
        super().__init__()
        self.n_bits = n_bits
        self.heads = heads
        self.d_model = d_model
        self.d_head = d_head

        scale = 0.2
        factory_kwargs = {"device": device, "dtype": dtype}
        self.token_embeddings = nn.Parameter(
            torch.randn(3, d_model, **factory_kwargs) * scale
        )
        self.positional_embeddings = nn.Parameter(
            torch.randn(n_bits + 1, d_model, **factory_kwargs) * scale
        )
        self.WQ = nn.Parameter(torch.randn(heads, d_head, d_model, **factory_kwargs) * scale)
        self.WK = nn.Parameter(torch.randn(heads, d_head, d_model, **factory_kwargs) * scale)
        self.WV = nn.Parameter(torch.randn(heads, d_head, d_model, **factory_kwargs) * scale)
        self.WO = nn.Parameter(torch.randn(heads, d_model, d_head, **factory_kwargs) * scale)
        self.readout = nn.Parameter(torch.randn(d_model, **factory_kwargs) * scale)
        self.threshold = nn.Parameter(torch.zeros((), **factory_kwargs))

    def forward(self, inputs: torch.Tensor) -> torch.Tensor:
        batch_size = inputs.shape[0]
        e_zero = self.token_embeddings[0]
        e_one = self.token_embeddings[1]
        e_query = self.token_embeddings[2]

        input_vectors = (
            (1.0 - inputs).unsqueeze(-1) * e_zero.view(1, 1, -1)
            + inputs.unsqueeze(-1) * e_one.view(1, 1, -1)
            + self.positional_embeddings[: self.n_bits].unsqueeze(0)
        )
        query_vector = e_query + self.positional_embeddings[self.n_bits]
        query_batch = query_vector.view(1, -1).expand(batch_size, -1)
        all_positions = torch.cat([input_vectors, query_batch.unsqueeze(1)], dim=1)

        residual = query_batch
        for head in range(self.heads):
            query = self.WQ[head] @ query_vector
            keys = all_positions @ self.WK[head].T
            values = all_positions @ self.WV[head].T
            logits = keys @ query
            weights = torch.softmax(logits, dim=1)
            head_output = torch.sum(weights.unsqueeze(-1) * values, dim=1)
            projected = head_output @ self.WO[head].T
            residual = residual + projected

        return residual @ self.readout - self.threshold


class AttentionModel:
    def __init__(
        self,
        n_bits: int,
        heads: int,
        d_model: int,
        d_head: int,
        seed: int,
        device_name: str = "auto",
    ):
        torch.manual_seed(seed)
        if torch.cuda.is_available():
            torch.cuda.manual_seed_all(seed)

        self.device, self.dtype = resolve_torch_device(device_name)
        self.module = TorchAttentionCore(
            n_bits=n_bits,
            heads=heads,
            d_model=d_model,
            d_head=d_head,
            device=self.device,
            dtype=self.dtype,
        )

    def fit(
        self,
        inputs: np.ndarray,
        targets: np.ndarray,
        steps: int,
        learning_rate: float,
        tolerance: float,
        stop_on_perfect_accuracy: bool = True,
        verbose: bool = False,
    ) -> dict[str, float | bool]:
        x_tensor = torch.tensor(inputs, dtype=self.dtype, device=self.device)
        y_tensor = torch.tensor(targets, dtype=self.dtype, device=self.device)
        optimizer = torch.optim.Adam(self.module.parameters(), lr=learning_rate)
        criterion = nn.BCEWithLogitsLoss()

        best_state = {
            key: value.detach().clone() for key, value in self.module.state_dict().items()
        }
        best_accuracy = -1.0
        best_loss = float("inf")
        best_step = 0
        first_perfect_step: int | None = None

        for step in range(1, steps + 1):
            optimizer.zero_grad()
            scores = self.module(x_tensor)
            loss = criterion(scores, y_tensor)
            loss.backward()
            optimizer.step()

            with torch.no_grad():
                scores = self.module(x_tensor)
                predictions = (scores > 0.0).to(dtype=self.dtype)
                accuracy = float((predictions == y_tensor).to(dtype=self.dtype).mean().item())
                loss_value = float(criterion(scores, y_tensor).item())

            if accuracy > best_accuracy or (accuracy == best_accuracy and loss_value < best_loss):
                best_accuracy = accuracy
                best_loss = loss_value
                best_step = step
                best_state = {
                    key: value.detach().clone()
                    for key, value in self.module.state_dict().items()
                }

            if accuracy == 1.0 and first_perfect_step is None:
                first_perfect_step = step

            if verbose and (step == 1 or step % 100 == 0 or accuracy == 1.0):
                print(
                    f"[train] step={step:4d} loss={loss_value:.6f} accuracy={accuracy:.3f}",
                    flush=True,
                )

            if stop_on_perfect_accuracy and accuracy == 1.0:
                break
            if (not stop_on_perfect_accuracy) and accuracy == 1.0 and loss_value < tolerance:
                break

        self.module.load_state_dict(best_state)
        with torch.no_grad():
            final_scores = self.module(x_tensor)
            final_predictions = (final_scores > 0.0).to(dtype=self.dtype)
            final_accuracy = float(
                (final_predictions == y_tensor).to(dtype=self.dtype).mean().item()
            )
            final_loss = float(criterion(final_scores, y_tensor).item())

        return {
            "loss": final_loss,
            "accuracy": final_accuracy,
            "fits_exactly": bool(final_accuracy == 1.0),
            "best_step": best_step,
            "first_perfect_step": first_perfect_step,
            "device": self.device.type,
            "dtype": str(self.dtype).removeprefix("torch."),
        }
