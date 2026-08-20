from __future__ import annotations

from dataclasses import asdict, replace
from typing import Callable

import numpy as np

from .attention_model import AttentionModel
from .config import SearchConfig, TrainingConfig
from .symmetry import representative_truth_tables
from .truth_tables import all_inputs, truth_table_array_to_bitstring


def _default_dimension(n_bits: int, heads: int) -> int:
    return max(4, n_bits + heads + 2)


def _is_constant(truth_table: np.ndarray) -> bool:
    return bool(np.all(truth_table == truth_table[0]))


def _search_experimental_head_count(
    truth_table,
    inputs,
    max_heads: int,
    training: TrainingConfig,
):
    attempted_heads = []
    for heads in range(1, max_heads + 1):
        attempted_heads.append(heads)
        d_model = training.d_model or _default_dimension(inputs.shape[1], heads)
        d_head = training.d_head or d_model
        for restart in range(training.restarts):
            model = AttentionModel(
                n_bits=inputs.shape[1],
                heads=heads,
                d_model=d_model,
                d_head=d_head,
                seed=10_000 * heads + restart,
                device_name=training.device,
            )
            result = model.fit(
                inputs=inputs,
                targets=truth_table,
                steps=training.steps,
                learning_rate=training.learning_rate,
                tolerance=training.tolerance,
                stop_on_perfect_accuracy=training.stop_on_perfect_accuracy,
                verbose=training.verbose,
            )
            if result["fits_exactly"]:
                return {
                    "status": "experimental",
                    "estimated_h_star": heads,
                    "method": "attention-training",
                    "restart": restart,
                    "d_model": d_model,
                    "d_head": d_head,
                    "device": result["device"],
                    "dtype": result["dtype"],
                    "fit_loss": result["loss"],
                    "best_step": result["best_step"],
                    "first_perfect_step": result["first_perfect_step"],
                    "attempted_heads": attempted_heads.copy(),
                }

    return {
        "status": "unresolved",
        "estimated_h_star": None,
        "method": "attention-training",
        "attempted_heads": attempted_heads,
    }


def _robust_training_config(config: SearchConfig) -> TrainingConfig:
    return replace(
        config.training,
        steps=config.training.steps * config.robust_steps_multiplier,
        restarts=config.training.restarts * config.robust_restarts_multiplier,
    )


def estimate_h_star(
    truth_table,
    inputs,
    config: SearchConfig,
):
    if _is_constant(truth_table):
        return {
            "status": "exact",
            "estimated_h_star": 0,
            "method": "constant",
        }

    base_result = _search_experimental_head_count(
        truth_table=truth_table,
        inputs=inputs,
        max_heads=config.max_heads,
        training=config.training,
    )
    if not config.robust_estimate:
        return base_result

    robust_info = {
        "enabled": True,
        "base_estimated_h_star": base_result["estimated_h_star"],
        "base_status": base_result["status"],
        "base_attempted_heads": base_result.get("attempted_heads", []),
    }
    robust_training = _robust_training_config(config)

    if base_result["estimated_h_star"] is None:
        refined_result = _search_experimental_head_count(
            truth_table=truth_table,
            inputs=inputs,
            max_heads=config.max_heads,
            training=robust_training,
        )
        refined_result["robust"] = {
            **robust_info,
            "phase": "fallback-full-search",
            "refined": refined_result["estimated_h_star"] != base_result["estimated_h_star"],
            "robust_steps": robust_training.steps,
            "robust_restarts": robust_training.restarts,
            "robust_attempted_heads": refined_result.get("attempted_heads", []),
        }
        return refined_result

    if base_result["estimated_h_star"] >= 2:
        refined_result = _search_experimental_head_count(
            truth_table=truth_table,
            inputs=inputs,
            max_heads=base_result["estimated_h_star"] - 1,
            training=robust_training,
        )
        if refined_result["estimated_h_star"] is not None:
            refined_result["robust"] = {
                **robust_info,
                "phase": "lower-head-check",
                "refined": True,
                "robust_steps": robust_training.steps,
                "robust_restarts": robust_training.restarts,
                "robust_attempted_heads": refined_result.get("attempted_heads", []),
            }
            return refined_result

        base_result["robust"] = {
            **robust_info,
            "phase": "lower-head-check",
            "refined": False,
            "robust_steps": robust_training.steps,
            "robust_restarts": robust_training.restarts,
            "robust_attempted_heads": refined_result.get("attempted_heads", []),
        }
        return base_result

    base_result["robust"] = {
        **robust_info,
        "phase": "not-needed",
        "refined": False,
        "robust_steps": robust_training.steps,
        "robust_restarts": robust_training.restarts,
        "robust_attempted_heads": [],
    }
    return base_result


def _build_payload(
    *,
    n_bits: int,
    config: SearchConfig,
    total_representatives: int,
    start_index: int,
    end_index: int,
    results: list[dict],
):
    return {
        "n_bits": n_bits,
        "config": asdict(config),
        "total_representatives": total_representatives,
        "start_index": start_index,
        "end_index": end_index,
        "processed_count": len(results),
        "results": results,
    }


def run_representative_search(
    n_bits: int,
    config: SearchConfig,
    limit: int | None = None,
    start_index: int = 0,
    end_index: int | None = None,
    progress_callback: Callable[[dict], None] | None = None,
):
    if n_bits > config.exhaustive_n_limit:
        raise ValueError(
            f"Exhaustive representative enumeration is only enabled for n <= {config.exhaustive_n_limit}."
        )

    inputs = all_inputs(n_bits)
    all_representatives = representative_truth_tables(n_bits)
    total_representatives = len(all_representatives)

    if end_index is None:
        end_index = total_representatives
    if not (0 <= start_index <= end_index <= total_representatives):
        raise ValueError(
            f"Representative slice must satisfy 0 <= start_index <= end_index <= {total_representatives}."
        )

    representatives = all_representatives[start_index:end_index]
    if limit is not None:
        representatives = representatives[:limit]
        end_index = start_index + len(representatives)

    results = []
    for offset, truth_table in enumerate(representatives):
        index = start_index + offset
        result = estimate_h_star(truth_table, inputs, config)
        results.append(
            {
                "index": index,
                "truth_table": truth_table_array_to_bitstring(truth_table),
                **result,
            }
        )
        if progress_callback is not None:
            progress_callback(
                _build_payload(
                    n_bits=n_bits,
                    config=config,
                    total_representatives=total_representatives,
                    start_index=start_index,
                    end_index=end_index,
                    results=results,
                )
            )

    return _build_payload(
        n_bits=n_bits,
        config=config,
        total_representatives=total_representatives,
        start_index=start_index,
        end_index=end_index,
        results=results,
    )
