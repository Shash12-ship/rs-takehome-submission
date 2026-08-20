from __future__ import annotations

from itertools import permutations
from typing import Iterable

import numpy as np

from .truth_tables import all_inputs, truth_table_array_to_int


def apply_safe_symmetry(
    truth_table: np.ndarray,
    inputs: np.ndarray,
    permutation: tuple[int, ...],
    global_input_flip: bool,
    output_flip: bool,
) -> np.ndarray:
    """Apply the safe symmetry group S_n x C_2^in x C_2^out."""
    transformed = inputs[:, permutation]
    if global_input_flip:
        transformed = 1.0 - transformed

    original_indices = np.array(
        [
            int("".join(str(int(bit)) for bit in row.astype(np.int64)), 2)
            for row in transformed
        ],
        dtype=np.int64,
    )
    result = truth_table[original_indices].copy()
    if output_flip:
        result = 1.0 - result
    return result


def orbit_tables(truth_table: np.ndarray, inputs: np.ndarray) -> list[np.ndarray]:
    n_bits = inputs.shape[1]
    orbit: dict[int, np.ndarray] = {}
    for permutation in permutations(range(n_bits)):
        for global_input_flip in (False, True):
            for output_flip in (False, True):
                transformed = apply_safe_symmetry(
                    truth_table,
                    inputs,
                    permutation,
                    global_input_flip,
                    output_flip,
                )
                orbit[truth_table_array_to_int(transformed)] = transformed
    return [orbit[key] for key in sorted(orbit)]


def canonical_representative(truth_table: np.ndarray, inputs: np.ndarray) -> np.ndarray:
    return orbit_tables(truth_table, inputs)[0]


def representative_truth_tables(n_bits: int) -> list[np.ndarray]:
    inputs = all_inputs(n_bits)
    table_count = 1 << (1 << n_bits)
    seen: set[int] = set()
    representatives: list[np.ndarray] = []
    for table_int in range(table_count):
        if table_int in seen:
            continue
        truth_table = np.array(
            [float(bit) for bit in f"{table_int:0{1 << n_bits}b}"], dtype=np.float64
        )
        orbit = orbit_tables(truth_table, inputs)
        representatives.append(orbit[0])
        seen.update(truth_table_array_to_int(item) for item in orbit)
    return representatives
