#!/usr/bin/env python
"""Verify the exact exhaustive four-bit head-complexity certificate.

The companion NPZ contains only integers.  This verifier does not solve any
linear programs and does not use floating-point arithmetic.  It checks:

1. explicit two-head scores for 28,787 complement-pair representatives;
2. positive-circuit obstructions to degree at most two for all other 3,981
   representatives;
3. explicit three-head scores for the 3,980 non-parity obstructions.

The remaining representative is parity.  The analytic parity theorem gives
both threshold degree and head complexity four.  Together with the analytic
zero-head and one-head classifications, the checked data proves
H*(f) = deg_pm(f) for every Boolean function on four bits.
"""
from __future__ import annotations

import itertools
from pathlib import Path

import numpy as np


HERE = Path(__file__).resolve().parent
ARCHIVE = HERE / "small_n4_exact_classification_certificate.npz"
HALF_SIZE = 1 << 15


def cube(n: int) -> np.ndarray:
    return ((np.arange(1 << n)[:, None] >> np.arange(n)) & 1).astype(np.int64)


def affine_matrix(n: int) -> np.ndarray:
    return np.column_stack([np.ones(1 << n, dtype=np.int64), cube(n)])


def monomial_matrix(n: int, degree: int) -> np.ndarray:
    x = cube(n)
    columns: list[np.ndarray] = []
    for size in range(degree + 1):
        for subset in itertools.combinations(range(n), size):
            if subset:
                columns.append(np.prod(x[:, subset], axis=1))
            else:
                columns.append(np.ones(1 << n, dtype=np.int64))
    return np.column_stack(columns).astype(np.int64)


def label_matrix(masks: np.ndarray) -> np.ndarray:
    bits = (masks.astype(np.uint32)[:, None] >> np.arange(16, dtype=np.uint32)) & 1
    return (2 * bits.astype(np.int64)) - 1


def head_matrix(denominators: np.ndarray) -> np.ndarray:
    """Integer cleared-score matrix for one fixed denominator dictionary."""
    affine = affine_matrix(4)
    values = [affine @ denominator for denominator in denominators]
    product = np.prod(values, axis=0)
    columns = [product]
    for h in range(len(values)):
        product_except = np.prod(
            [values[g] for g in range(len(values)) if g != h], axis=0
        )
        columns.extend((affine * product_except[:, None]).T)
    return np.column_stack(columns).astype(np.int64)


def check_denominators(dictionaries: np.ndarray) -> None:
    affine = affine_matrix(4)
    for dictionary in dictionaries:
        for denominator in dictionary:
            slopes = denominator[1:]
            assert np.all(slopes > 0) or np.all(slopes < 0)
            assert np.all(affine @ denominator > 0)


def check_score_certificates(
    masks: np.ndarray,
    dictionary_indices: np.ndarray,
    coefficients: np.ndarray,
    dictionaries: np.ndarray,
) -> None:
    assert len(masks) == len(dictionary_indices) == len(coefficients)
    assert np.array_equal(masks, np.unique(masks))
    assert np.all(masks < HALF_SIZE)
    signs = label_matrix(masks)
    for dictionary_index in np.unique(dictionary_indices):
        selection = np.flatnonzero(dictionary_indices == dictionary_index)
        matrix = head_matrix(dictionaries[int(dictionary_index)])
        selected_coefficients = coefficients[selection]

        row_l1 = int(np.max(np.sum(np.abs(matrix), axis=1)))
        coefficient_max = int(np.max(np.abs(selected_coefficients)))
        assert row_l1 * coefficient_max < (1 << 63)

        scores = selected_coefficients @ matrix.T
        assert np.all(signs[selection] * scores > 0)


def parity_mask(n: int) -> int:
    return sum(1 << x for x in range(1 << n) if bin(x).count("1") & 1)


def main() -> None:
    data = np.load(ARCHIVE)

    h2_denominators = data["h2_denominators"]
    h2_masks = data["h2_masks"]
    h2_dictionary = data["h2_dictionary"]
    h2_coefficients = data["h2_coefficients"]
    obstruction_masks = data["obstruction_masks"]
    degree2_duals = data["degree2_duals"]
    h3_denominators = data["h3_denominators"]
    h3_masks = data["h3_masks"]
    h3_dictionary = data["h3_dictionary"]
    h3_coefficients = data["h3_coefficients"]

    assert h2_denominators.shape[1:] == (2, 5)
    assert h3_denominators.shape[1:] == (3, 5)
    check_denominators(h2_denominators)
    check_denominators(h3_denominators)
    check_score_certificates(
        h2_masks, h2_dictionary, h2_coefficients, h2_denominators
    )

    assert np.array_equal(obstruction_masks, np.unique(obstruction_masks))
    assert np.all(obstruction_masks < HALF_SIZE)
    assert np.all(degree2_duals >= 0)
    assert np.all(np.any(degree2_duals > 0, axis=1))
    degree2 = monomial_matrix(4, 2)
    signed_duals = label_matrix(obstruction_masks) * degree2_duals
    assert np.all(signed_duals @ degree2 == 0)

    all_representatives = set(range(HALF_SIZE))
    h2_set = set(map(int, h2_masks))
    obstruction_set = set(map(int, obstruction_masks))
    assert h2_set.isdisjoint(obstruction_set)
    assert h2_set | obstruction_set == all_representatives

    parity = parity_mask(4)
    assert parity < HALF_SIZE
    assert parity in obstruction_set
    assert set(map(int, h3_masks)) == obstruction_set - {parity}
    check_score_certificates(
        h3_masks, h3_dictionary, h3_coefficients, h3_denominators
    )

    assert len(h2_masks) == 28_787
    assert len(obstruction_masks) == 3_981
    assert len(h3_masks) == 3_980
    print("Exact integer certificate verified.")
    print("Complement-pair representatives with degree <= 2 and H* <= 2: 28,787")
    print("Complement-pair representatives with degree >= 3: 3,981")
    print("Non-parity representatives among them with degree = H* = 3: 3,980")
    print("The final pair is parity and its complement, with degree = H* = 4.")
    print("Therefore H*(f) = deg_pm(f) for every Boolean function on at most four bits.")


if __name__ == "__main__":
    main()
