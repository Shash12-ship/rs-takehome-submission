from __future__ import annotations

from itertools import product
from typing import Iterable

import numpy as np


def all_inputs(n_bits: int) -> np.ndarray:
    """Return all Boolean inputs in lexicographic order."""
    return np.array(list(product([0.0, 1.0], repeat=n_bits)), dtype=np.float64)


def truth_table_int_to_array(table_int: int, n_bits: int) -> np.ndarray:
    length = 1 << n_bits
    bits = f"{table_int:0{length}b}"
    return np.fromiter((float(ch) for ch in bits), dtype=np.float64, count=length)


def truth_table_array_to_int(table: np.ndarray) -> int:
    bits = "".join(str(int(v)) for v in table.astype(np.int64))
    return int(bits, 2)


def truth_table_array_to_bitstring(table: np.ndarray) -> str:
    return "".join(str(int(v)) for v in table.astype(np.int64))


def all_truth_tables(n_bits: int) -> Iterable[np.ndarray]:
    table_count = 1 << (1 << n_bits)
    for table_int in range(table_count):
        yield truth_table_int_to_array(table_int, n_bits)


def flip_coordinate(truth_table: np.ndarray, n_bits: int, coordinate: int) -> np.ndarray:
    """Return the truth table for x -> f(..., 1 - x_coordinate, ...)."""
    inputs = all_inputs(n_bits)
    index = {tuple(row.astype(np.int64)): i for i, row in enumerate(inputs)}
    flipped = np.zeros_like(truth_table)
    for x in inputs:
        y = x.copy()
        y[coordinate] = 1.0 - y[coordinate]
        flipped[index[tuple(x.astype(np.int64))]] = truth_table[index[tuple(y.astype(np.int64))]]
    return flipped
