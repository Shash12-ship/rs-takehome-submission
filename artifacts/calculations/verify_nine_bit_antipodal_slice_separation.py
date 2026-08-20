#!/usr/bin/env python3
"""Verify the exact finite identities in the nine-bit separation."""

from __future__ import annotations

from itertools import permutations, product


X_BITS = 4
Y_BITS = 5


def determinant(matrix: tuple[tuple[int, ...], ...]) -> int:
    size = len(matrix)
    answer = 0
    for permutation in permutations(range(size)):
        inversions = sum(
            permutation[first] > permutation[second]
            for first in range(size)
            for second in range(first + 1, size)
        )
        term = 1
        for row in range(size):
            term *= matrix[row][permutation[row]]
        answer += (-1 if inversions % 2 else 1) * term
    return answer


def q_value(x: tuple[int, ...], y: tuple[int, ...]) -> int:
    statistic_y = sum(y)
    statistic_x = 1 + sum(x)
    diagonal = y[0] + sum(
        x[index - 1] * y[index] for index in range(1, Y_BITS)
    )
    return statistic_y * statistic_x - 3 * diagonal


def main() -> None:
    all_ones = tuple(tuple(1 for _ in range(Y_BITS)) for _ in range(Y_BITS))
    identity = tuple(
        tuple(1 if row == column else 0 for column in range(Y_BITS))
        for row in range(Y_BITS)
    )
    v_matrix = tuple(
        tuple(all_ones[row][column] - 2 * identity[row][column] for column in range(Y_BITS))
        for row in range(Y_BITS)
    )
    cross_matrix = tuple(
        tuple(all_ones[row][column] - 3 * identity[row][column] for column in range(Y_BITS))
        for row in range(Y_BITS)
    )
    assert determinant(v_matrix) == 48
    assert determinant(cross_matrix) == 162

    product_matrix = tuple(
        tuple(
            sum(cross_matrix[row][middle] * v_matrix[middle][column] for middle in range(Y_BITS))
            for column in range(Y_BITS)
        )
        for row in range(Y_BITS)
    )
    assert product_matrix == tuple(
        tuple(6 if row == column else 0 for column in range(Y_BITS))
        for row in range(Y_BITS)
    )

    values = []
    selected_pairs = []
    for x in product((-1, 1), repeat=X_BITS):
        for y in product((-1, 1), repeat=Y_BITS):
            value = q_value(x, y)
            assert value % 4 == 2
            values.append(value)
        for selected in range(Y_BITS):
            y = tuple(-1 if coordinate == selected else 1 for coordinate in range(Y_BITS))
            expected = 6 if selected == 0 else 6 * x[selected - 1]
            assert q_value(x, y) == expected
            assert q_value(x, tuple(-entry for entry in y)) == -expected
            selected_pairs.append((x, selected))

    assert min(values) == -14
    assert max(values) == 14
    assert min(abs(value) for value in values) == 2
    assert len(selected_pairs) == (1 << X_BITS) * Y_BITS

    print("input bits:", X_BITS + Y_BITS)
    print("Q value range:", (min(values), max(values)))
    print("minimum absolute Q value:", min(abs(value) for value in values))
    print("selected antipodal pairs:", Y_BITS)
    print("det(V):", determinant(v_matrix))
    print("det(J - 3I):", determinant(cross_matrix))
    print("certificate: verified")


if __name__ == "__main__":
    main()
