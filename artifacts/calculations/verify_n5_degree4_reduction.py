#!/usr/bin/env python3
"""Verify the finite five-bit degree-four weak-LTF reduction.

For a five-bit sign table s and the top parity character chi, Gordan's
alternative says that s has threshold degree at least four exactly when
t = s * chi has a nonzero weak affine separator.  Every nonzero pointed
weak-separator cone has an extreme ray on five independent cube constraints.
Thus it is enough to enumerate affine hyperplanes through five independent
vertices, then allow arbitrary labels on their zero sets.

All determinant calculations below are exact modulo 127.  Every relevant
5 by 5 determinant has rows of Euclidean norm sqrt(5), so Hadamard's bound is
strictly below 56.  Its residue modulo 127 therefore determines the integer
determinant uniquely in the interval [-63, 63].
"""

from __future__ import annotations

from collections import Counter
from itertools import combinations
from math import gcd

import numpy as np


INPUT_BITS = 5
VERTEX_COUNT = 1 << INPUT_BITS
FULL_MASK = (1 << VERTEX_COUNT) - 1
PRIME = 127
BATCH_SIZE = 10_000

EXPECTED_NORMAL_COUNT = 3_254
EXPECTED_NORMAL_ORBIT_COUNT = 65
EXPECTED_ZERO_COUNTS = {
    5: 2_112,
    7: 480,
    8: 480,
    10: 32,
    12: 120,
    16: 30,
}
EXPECTED_ORBIT_ZERO_COUNTS = {
    5: 31,
    7: 11,
    8: 12,
    10: 3,
    12: 5,
    16: 3,
}
EXPECTED_WEAK_MASK_COUNT = 4_475_540


def affine_features() -> np.ndarray:
    vertices = (
        (np.arange(VERTEX_COUNT)[:, None] >> np.arange(INPUT_BITS)) & 1
    ).astype(np.int16)
    sign_vertices = 2 * vertices - 1
    return np.column_stack(
        [np.ones(VERTEX_COUNT, dtype=np.int16), sign_vertices]
    )


def determinant_mod_prime(matrices: np.ndarray) -> np.ndarray:
    """Return exact signed 5 by 5 determinants using residues modulo 127."""
    matrices = (matrices.copy() % PRIME).astype(np.int16)
    count = len(matrices)
    determinants = np.ones(count, dtype=np.int64)
    alive = np.ones(count, dtype=bool)
    inverses = np.zeros(PRIME, dtype=np.int16)
    for value in range(1, PRIME):
        inverses[value] = pow(value, -1, PRIME)

    for column in range(5):
        nonzero = matrices[:, column:, column] != 0
        has_pivot = np.any(nonzero, axis=1) & alive
        alive &= has_pivot
        pivot_rows = column + np.argmax(nonzero, axis=1)

        swap = has_pivot & (pivot_rows != column)
        temporary = matrices[swap, column, :].copy()
        matrices[swap, column, :] = matrices[swap, pivot_rows[swap], :]
        matrices[swap, pivot_rows[swap], :] = temporary
        determinants[swap] *= -1

        pivots = matrices[:, column, column].astype(np.int64)
        determinants[has_pivot] *= pivots[has_pivot]
        determinants[has_pivot] %= PRIME
        inverse_pivots = inverses[pivots % PRIME]

        for row in range(column + 1, 5):
            factors = (
                matrices[:, row, column].astype(np.int64) * inverse_pivots
            ) % PRIME
            matrices[:, row, column:] = (
                matrices[:, row, column:].astype(np.int64)
                - factors[:, None]
                * matrices[:, column, column:].astype(np.int64)
            ) % PRIME

    determinants[~alive] = 0
    determinants %= PRIME
    return np.where(
        determinants > PRIME // 2,
        determinants - PRIME,
        determinants,
    )


def primitive_normal(vector: np.ndarray) -> tuple[int, ...]:
    common = 0
    for value in vector:
        common = gcd(common, abs(int(value)))
    vector = vector // common
    first_nonzero = int(np.flatnonzero(vector)[0])
    if vector[first_nonzero] < 0:
        vector = -vector
    return tuple(int(value) for value in vector)


def enumerate_rank_five_normals(features: np.ndarray) -> set[tuple[int, ...]]:
    five_subsets = np.array(
        list(combinations(range(VERTEX_COUNT), 5)), dtype=np.int16
    )
    normals: set[tuple[int, ...]] = set()
    for start in range(0, len(five_subsets), BATCH_SIZE):
        rows = features[five_subsets[start : start + BATCH_SIZE]]
        cross_products = np.empty((len(rows), 6), dtype=np.int64)
        for omitted in range(6):
            columns = np.arange(6) != omitted
            cross_products[:, omitted] = (
                (-1) ** omitted
            ) * determinant_mod_prime(rows[:, :, columns])
        for vector in cross_products:
            if np.any(vector):
                normals.add(primitive_normal(vector))
    return normals


def normal_orbit_key(normal: tuple[int, ...]) -> tuple[int, ...]:
    """Canonicalize under S5, global input complement, and normal sign."""
    constant = normal[0]
    slopes = tuple(sorted(normal[1:]))
    negative_slopes = tuple(sorted(-value for value in normal[1:]))
    return min(
        (constant,) + slopes,
        (-constant,) + negative_slopes,
        (constant,) + negative_slopes,
        (-constant,) + slopes,
    )


def mask_from_boolean(values: np.ndarray) -> int:
    return sum((int(value) > 0) << index for index, value in enumerate(values))


def zero_subsets(zero_mask: int) -> np.ndarray:
    zero_vertices = [
        vertex for vertex in range(VERTEX_COUNT) if (zero_mask >> vertex) & 1
    ]
    choices = np.arange(1 << len(zero_vertices), dtype=np.uint32)
    subsets = np.zeros(len(choices), dtype=np.uint32)
    for coordinate, vertex in enumerate(zero_vertices):
        subsets |= ((choices >> coordinate) & 1) << vertex
    return subsets


def weak_affine_masks(
    features: np.ndarray, normals: set[tuple[int, ...]]
) -> tuple[np.ndarray, Counter[int]]:
    covectors = []
    zero_counts: Counter[int] = Counter()
    raw_count = 0
    for normal in normals:
        values = features @ np.array(normal, dtype=np.int64)
        positive_mask = mask_from_boolean(values)
        negative_mask = mask_from_boolean(-values)
        zero_mask = FULL_MASK ^ positive_mask ^ negative_mask
        zero_count = int(bin(zero_mask).count("1"))
        assert zero_count >= 5
        zero_counts[zero_count] += 1
        covectors.append((positive_mask, negative_mask, zero_mask))
        raw_count += 2 * (1 << zero_count)

    raw_masks = np.empty(raw_count, dtype=np.uint32)
    cursor = 0
    for positive_mask, negative_mask, zero_mask in covectors:
        subsets = zero_subsets(zero_mask)
        count = len(subsets)
        raw_masks[cursor : cursor + count] = positive_mask | subsets
        cursor += count
        raw_masks[cursor : cursor + count] = negative_mask | subsets
        cursor += count
    assert cursor == raw_count
    return np.unique(raw_masks), zero_counts


def parity_positive_mask() -> int:
    return sum(
        1 << vertex
        for vertex in range(VERTEX_COUNT)
        if bin(vertex).count("1") % 2 == 1
    )


def parity_twist(mask: int) -> int:
    return FULL_MASK ^ (mask ^ parity_positive_mask())


def main() -> None:
    features = affine_features()
    normals = enumerate_rank_five_normals(features)
    assert len(normals) == EXPECTED_NORMAL_COUNT

    orbit_zero_sizes: dict[tuple[int, ...], int] = {}
    for normal in normals:
        values = features @ np.array(normal, dtype=np.int64)
        zero_count = int(np.count_nonzero(values == 0))
        key = normal_orbit_key(normal)
        if key in orbit_zero_sizes:
            assert orbit_zero_sizes[key] == zero_count
        else:
            orbit_zero_sizes[key] = zero_count
    orbit_zero_counts = Counter(orbit_zero_sizes.values())
    assert len(orbit_zero_sizes) == EXPECTED_NORMAL_ORBIT_COUNT
    assert dict(sorted(orbit_zero_counts.items())) == EXPECTED_ORBIT_ZERO_COUNTS

    weak_masks, zero_counts = weak_affine_masks(features, normals)
    assert dict(sorted(zero_counts.items())) == EXPECTED_ZERO_COUNTS
    assert len(weak_masks) == EXPECTED_WEAK_MASK_COUNT

    weak_set = set(int(mask) for mask in weak_masks)
    degree_four_mask = 0x966B6996
    degree_three_masks = (0x149AC934, 0x96E86B96)
    assert parity_twist(degree_four_mask) in weak_set
    assert all(parity_twist(mask) not in weak_set for mask in degree_three_masks)

    print(f"rank-five affine normals up to sign: {len(normals)}")
    print(f"zero-set size distribution: {dict(sorted(zero_counts.items()))}")
    print(f"affine-normal symmetry orbits: {len(orbit_zero_sizes)}")
    print(
        "orbit zero-set size distribution: "
        f"{dict(sorted(orbit_zero_counts.items()))}"
    )
    print(f"weak affine sign extensions: {len(weak_masks)}")
    print(f"five-bit exact degree-four functions: {len(weak_masks) - 2}")


if __name__ == "__main__":
    main()
