#!/usr/bin/env python3
"""Verify the exact finite identities in the eight-bit HDTH4 separation."""

from __future__ import annotations

from fractions import Fraction
from itertools import combinations, permutations, product


DIMENSION = 4
F = Fraction


def add(left: tuple[int, ...], right: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(a + b for a, b in zip(left, right))


def subtract(left: tuple[int, ...], right: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(a - b for a, b in zip(left, right))


def scale(value: int, vector: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(value * entry for entry in vector)


def dot(left, matrix, right):
    return sum(
        left[row] * matrix[row][column] * right[column]
        for row in range(len(left))
        for column in range(len(right))
    )


def hamming(left: tuple[int, ...], right: tuple[int, ...]) -> int:
    return sum(a != b for a, b in zip(left, right))


def target_sign(left: tuple[int, ...], right: tuple[int, ...]) -> int:
    return 1 if hamming(left, right) >= 2 else -1


def bits(text: str) -> tuple[int, ...]:
    return tuple(int(character) for character in text)


E = tuple(
    tuple(1 if row == column else 0 for column in range(DIMENSION))
    for row in range(DIMENSION)
)
PREFIX = tuple(
    tuple(1 if coordinate <= index else 0 for coordinate in range(DIMENSION))
    for index in range(DIMENSION)
)


RECTANGLES = (
    (PREFIX[0], PREFIX[0], "1000", "0000", "1001", "0001"),
    (PREFIX[1], PREFIX[1], "1100", "0000", "1100", "0000"),
    (PREFIX[2], PREFIX[2], "1110", "0000", "1110", "0000"),
    (PREFIX[3], PREFIX[3], "1111", "0000", "1111", "0000"),
    (PREFIX[0], PREFIX[2], "1010", "0010", "1110", "0000"),
    (PREFIX[1], PREFIX[2], "1100", "0000", "1110", "0000"),
    (PREFIX[1], PREFIX[3], "1101", "0001", "1111", "0000"),
    (PREFIX[2], PREFIX[3], "1110", "0000", "1111", "0000"),
    (PREFIX[0], subtract(PREFIX[1], E[2]), "1000", "0000", "1100", "0010"),
    (PREFIX[0], subtract(PREFIX[3], E[1]), "1001", "0001", "1011", "0000"),
    (PREFIX[0], subtract(PREFIX[3], E[2]), "1001", "0001", "1101", "0000"),
    (PREFIX[3], add(E[0], E[1]), "1111", "0000", "1101", "0001"),
    (PREFIX[3], add(E[0], E[2]), "1111", "0000", "1011", "0001"),
    (PREFIX[3], add(E[0], E[3]), "1111", "0000", "1011", "0010"),
)


def verify_truth_table() -> tuple[int, int, int]:
    values = []
    for left in product((0, 1), repeat=DIMENSION):
        for right in product((0, 1), repeat=DIMENSION):
            doubled_score = 2 * hamming(left, right) - 3
            assert doubled_score != 0
            assert (doubled_score > 0) == (target_sign(left, right) > 0)
            values.append(doubled_score)

    for first, second in product((0, 1), repeat=2):
        left = (0, first, 0, 0)
        right = (1, second, 0, 0)
        assert (target_sign(left, right) > 0) == (first != second)

    return min(values), max(values), min(abs(value) for value in values)


def verify_curvature_certificate() -> None:
    for a, b, x0_text, x1_text, y0_text, y1_text in RECTANGLES:
        x0, x1 = bits(x0_text), bits(x1_text)
        y0, y1 = bits(y0_text), bits(y1_text)
        assert subtract(x0, x1) == a
        assert subtract(y0, y1) == b
        assert (
            target_sign(x0, y0),
            target_sign(x0, y1),
            target_sign(x1, y0),
            target_sign(x1, y1),
        ) == (-1, 1, 1, -1)

    assert add(subtract(PREFIX[1], E[2]), PREFIX[2]) == scale(2, PREFIX[1])
    q_vectors = tuple(subtract(PREFIX[3], E[index]) for index in (1, 2, 3))
    assert tuple(map(sum, zip(*q_vectors))) == add(PREFIX[0], scale(2, PREFIX[3]))
    r_vectors = tuple(add(E[0], E[index]) for index in (1, 2, 3))
    assert tuple(map(sum, zip(*r_vectors))) == add(scale(2, PREFIX[0]), PREFIX[3])

    signed_permutations = 0
    for permutation in permutations(range(DIMENSION)):
        for signs in product((-1, 1), repeat=DIMENSION):
            rows = tuple(
                tuple(
                    signs[row] if column == permutation[row] else 0
                    for column in range(DIMENSION)
                )
                for row in range(DIMENSION)
            )
            gram = tuple(
                tuple(sum(rows[i][k] * rows[j][k] for k in range(DIMENSION)) for j in range(DIMENSION))
                for i in range(DIMENSION)
            )
            assert gram == E
            signed_permutations += 1
    assert signed_permutations == 384


def symmetric_zero_row_matrix(edge_values: tuple[Fraction, ...]):
    pairs = tuple(combinations(range(DIMENSION), 2))
    matrix = [[F(0) for _ in range(DIMENSION)] for _ in range(DIMENSION)]
    for value, (first, second) in zip(edge_values, pairs):
        matrix[first][second] = value
        matrix[second][first] = value
    for row in range(DIMENSION):
        matrix[row][row] = -sum(matrix[row][column] for column in range(DIMENSION) if column != row)
    return tuple(tuple(row) for row in matrix)


def verify_column_choice_cone() -> int:
    q = (F(2), F(3), F(5), F(7))
    matrix = symmetric_zero_row_matrix((F(2), F(-3), F(5), F(7), F(-11), F(13)))
    choices = tuple(tuple(index for index in range(DIMENSION) if index != column) for column in range(DIMENSION))
    maps = tuple(product(*choices))
    assert len(maps) == 81

    linear_values = []
    for mapping in maps:
        linear = sum(q[index] * matrix[index][index] for index in range(DIMENSION))
        linear += 2 * sum(q[mapping[column]] * matrix[mapping[column]][column] for column in range(DIMENSION))
        coefficient_sum = F(0)
        for first, second in combinations(range(DIMENSION), 2):
            coefficient = q[first] + q[second]
            coefficient -= 2 * q[first] * int(mapping[second] == first)
            coefficient -= 2 * q[second] * int(mapping[first] == second)
            coefficient_sum += matrix[first][second] * coefficient
        assert -linear == coefficient_sum
        linear_values.append(linear)

    functional = sum(q[index] * matrix[index][index] for index in range(DIMENSION))
    functional += 2 * sum(
        max(q[index] * matrix[index][column] for index in choices[column])
        for column in range(DIMENSION)
    )
    assert functional == max(linear_values)
    return len(maps)


def verify_fractional_capacities() -> None:
    q = (F(2), F(3), F(5), F(7))
    v = tuple(1 / value for value in q)
    x = (F(-4), F(1), F(3), F(9))
    total = sum(v)
    mean = sum(weight * value for weight, value in zip(v, x)) / total
    variance = sum(weight * (value - mean) ** 2 for weight, value in zip(v, x))
    normalized_distance = {
        (first, second): (x[first] - x[second]) ** 2 / variance
        for first, second in combinations(range(DIMENSION), 2)
    }
    capacities = {
        (first, second): v[first]
        * v[second]
        * (q[first] + q[second] - normalized_distance[first, second])
        / 2
        for first, second in combinations(range(DIMENSION), 2)
    }
    assert all(value >= 0 for value in capacities.values())
    assert sum(capacities.values()) == total

    vertices = range(DIMENSION)
    for size in range(DIMENSION + 1):
        for subset in combinations(vertices, size):
            demand = sum(v[index] for index in subset)
            internal = sum(
                capacities[first, second]
                for first, second in combinations(subset, 2)
            )
            assert demand >= internal

    for missing in vertices:
        incident = sum(
            capacities[min(missing, other), max(missing, other)]
            for other in vertices
            if other != missing
        )
        centered_square = (x[missing] - mean) ** 2 / variance
        expected = (total + v[missing] - total * v[missing] * centered_square) / 2
        assert incident == expected
        assert incident >= v[missing]


def verify_normalized_index_reduction() -> None:
    g = (F(3), F(2), F(-1), F(-4))
    q = (F(2), F(3), F(5), F(7))
    off_diagonal = (F(2), F(-1), F(3), F(4), F(-2), F(5))
    pairs = tuple(combinations(range(DIMENSION), 2))
    h = [[F(0) for _ in range(DIMENSION)] for _ in range(DIMENSION)]
    for value, (first, second) in zip(off_diagonal, pairs):
        h[first][second] = value
        h[second][first] = value
    for row in range(DIMENSION):
        h[row][row] = g[row] - sum(h[row][column] for column in range(DIMENSION) if column != row)
    h = tuple(tuple(row) for row in h)
    assert tuple(sum(row) for row in h) == g
    assert sum(g) == 0

    r = tuple(1 / value for value in q)
    signs = tuple(1 if value > 0 else -1 for value in g)
    w_matrix = tuple(
        tuple(h[row][column] / (r[row] * r[column]) for column in range(DIMENSION))
        for row in range(DIMENSION)
    )
    v_matrix = tuple(
        tuple(signs[row] * signs[column] * w_matrix[row][column] for column in range(DIMENSION))
        for row in range(DIMENSION)
    )
    mu = tuple(signs[index] * r[index] for index in range(DIMENSION))
    b = tuple(sum(v_matrix[row][column] * mu[column] for column in range(DIMENSION)) for row in range(DIMENSION))
    assert all(value > 0 for value in b)
    assert dot(mu, v_matrix, mu) == 0
    assert sum(b) == sum(q[index] * abs(g[index]) for index in range(DIMENSION))

    r_min_from_v = F(0)
    r_min_from_h = F(0)
    for row in range(DIMENSION):
        base_v = mu[row] * sum(
            signs[column] * v_matrix[row][column]
            for column in range(DIMENSION)
            if column != row
        )
        penalty_v = 2 * max(
            mu[row] * signs[column] * v_matrix[row][column]
            for column in range(DIMENSION)
            if column != row
        )
        r_min_from_v += base_v - penalty_v

        base_h = sum(q[column] * h[row][column] for column in range(DIMENSION) if column != row)
        penalty_h = 2 * max(q[column] * h[row][column] for column in range(DIMENSION) if column != row)
        r_min_from_h += base_h - penalty_h
    assert r_min_from_v == r_min_from_h

    direct_l = sum(b) - r_min_from_h
    c = tuple(
        tuple(
            h[row][column]
            + (abs(g[row]) - g[row] if row == column else 0)
            for column in range(DIMENSION)
        )
        for row in range(DIMENSION)
    )
    assert tuple(sum(row) for row in c) == tuple(abs(value) for value in g)
    functional = sum(q[index] * c[index][index] for index in range(DIMENSION))
    functional += 2 * sum(
        max(q[index] * c[index][column] for index in range(DIMENSION) if index != column)
        for column in range(DIMENSION)
    )
    assert direct_l == functional

    m = tuple(
        tuple(q[row] * c[row][column] for column in range(DIMENSION))
        for row in range(DIMENSION)
    )
    assert all(sum(row) > 0 for row in m)
    m_functional = sum(m[index][index] for index in range(DIMENSION))
    m_functional += 2 * sum(
        max(m[index][column] for index in range(DIMENSION) if index != column)
        for column in range(DIMENSION)
    )
    assert functional == m_functional

    for x_value in range(-5, 6):
        for y_value in range(-5, 6):
            for sign in (-1, 1):
                assert -abs(x_value - y_value) - sign * x_value <= -sign * y_value
                assert -abs(x_value + y_value) - sign * x_value <= sign * y_value


def main() -> None:
    minimum, maximum, margin = verify_truth_table()
    verify_curvature_certificate()
    map_count = verify_column_choice_cone()
    verify_fractional_capacities()
    verify_normalized_index_reduction()

    print("input bits:", 2 * DIMENSION)
    print("quadratic value range:", (minimum, maximum))
    print("minimum doubled margin:", margin)
    print("checkerboard rectangles:", len(RECTANGLES))
    print("column-choice maps:", map_count)
    print("certificate: verified")


if __name__ == "__main__":
    main()
