from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class TrainingConfig:
    steps: int = 1500
    learning_rate: float = 3e-2
    restarts: int = 8
    tolerance: float = 1e-9
    d_model: int | None = 32
    d_head: int | None = 32
    device: str = "auto"
    stop_on_perfect_accuracy: bool = True
    verbose: bool = False


@dataclass(frozen=True)
class SearchConfig:
    max_heads: int
    training: TrainingConfig
    exhaustive_n_limit: int = 4
    robust_estimate: bool = False
    robust_steps_multiplier: int = 4
    robust_restarts_multiplier: int = 4
