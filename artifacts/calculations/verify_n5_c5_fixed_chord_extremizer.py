#!/usr/bin/env python3
"""Verify edge-extremal certificates on locked C5 cells.

For every cell supplied by the locked-cell walk or the exhaustive incidence
archive, this verifier does the following:

1. maximize signed edge coefficients on the compact normalized closed sign
   cell, trying the fixed chord 02 first;
2. reconstruct the resulting optimizer ray over the rationals;
3. certify optimality by an exact rational LP dual;
4. perturb toward an exact rational interior representative; and
5. verify one of the two-scale Schur systems with exact rational arithmetic.

The only non-exact step is discovery of candidate supports and witnesses.
Every assertion used in the reported counts is then checked over Fraction.
With ``--incidence``, exhaustive coverage of the input archive is combined
with the separate exact cocircuit tangent-cover verification.
"""

from __future__ import annotations

import argparse
from collections import Counter
from fractions import Fraction
from functools import reduce
import json
from itertools import permutations
from math import gcd, lcm
from pathlib import Path

import numpy as np
from scipy.optimize import linprog

import screen_n5_c5_two_scale as c5
import survey_n5_c5_locked_cells as survey


FIXED_EDGE = (0, 2)
EPSILONS = (
    Fraction(1, 10_000_000),
    Fraction(1, 1_000_000),
    Fraction(1, 100_000),
    Fraction(1, 10_000),
    Fraction(1, 1_000),
    Fraction(1, 100),
    Fraction(1, 20),
    Fraction(1, 10),
    Fraction(1, 4),
    Fraction(1, 2),
)

BRIDGE_RAY = (
    -1, 1, -1, 0, 0, 0, 1, -1, 0, 1, 1, 0, -1, 0, 0, 0,
)
BRIDGE_MASKS = (
    0x3B8AD093,
    0x3B8AD091,
    0x3B8AD099,
    0x3B8AD089,
    0x3B8AC089,
    0x3A8AC089,
)
BRIDGE_SEPARATORS = (
    (-7, 10, -12, 4, -2, -2, 10, -6, -4, 10, 5, -3, -2, 5, -10, 2),
    (-7, 9, -11, 4, -2, -2, 10, -5, -4, 10, 4, -2, -3, 4, -9, 2),
    (-5, 7, -5, 0, -2, -2, 8, -3, -4, 8, 2, -2, -5, 4, -5, 2),
    (-5, 7, -3, -2, -2, -2, 8, -3, -4, 8, 2, -2, -7, 4, -3, 2),
    (-7, 9, -2, -5, -2, -2, 10, -2, -7, 10, 4, -2, -12, 4, -3, 5),
    (-10, 12, -2, -5, -5, -2, 13, -6, -6, 13, 4, -2, -15, 7, -2, 4),
)
BRIDGE_UNLOCKING_SEPARATORS = (
    (-10, 4, -6, 4, -2, -2, 13, 7, -7, 17, -5, -6, -6, 8, -16, 5),
    (-5, 5, -2, -1, -2, -2, 8, 2, -7, 8, 0, -2, -6, 4, -7, 5),
    (-6, 8, -2, -4, -2, -2, 9, 3, -11, 9, 3, -2, -10, 4, -8, 9),
    (-7, 16, -2, -5, -2, -9, 17, 4, -13, 10, 4, -2, -19, 4, -9, 11),
)


def target_signs(mask: int) -> np.ndarray:
    return np.array(
        [1 if (mask >> vertex) & 1 else -1 for vertex in range(32)],
        dtype=np.int64,
    )


def modular_rank(matrix: np.ndarray, prime: int = 127) -> int:
    reduced = matrix.astype(np.int64).copy() % prime
    rank = 0
    for column in range(reduced.shape[1]):
        pivot = next(
            (
                row
                for row in range(rank, reduced.shape[0])
                if reduced[row, column] % prime
            ),
            None,
        )
        if pivot is None:
            continue
        reduced[[rank, pivot]] = reduced[[pivot, rank]]
        inverse = pow(int(reduced[rank, column]), -1, prime)
        reduced[rank] = reduced[rank] * inverse % prime
        for row in range(reduced.shape[0]):
            if row == rank or reduced[row, column] == 0:
                continue
            reduced[row] = (
                reduced[row] - reduced[row, column] * reduced[rank]
            ) % prime
        rank += 1
        if rank == reduced.shape[0]:
            break
    return rank


def verify_extreme_ray_bridge() -> None:
    fourier = c5.FOURIER.astype(np.int64)
    ray_values = fourier @ np.array(BRIDGE_RAY, dtype=np.int64)
    zero_vertices = np.flatnonzero(ray_values == 0)
    assert len(zero_vertices) == 22
    assert modular_rank(fourier[zero_vertices]) == 15

    differing_vertices = []
    for first, second in zip(BRIDGE_MASKS, BRIDGE_MASKS[1:]):
        difference = first ^ second
        assert bin(difference).count("1") == 1
        differing_vertices.append((difference & -difference).bit_length() - 1)
    assert tuple(differing_vertices) == (1, 3, 4, 12, 24)
    assert modular_rank(fourier[differing_vertices]) == 5

    for mask, coefficients in zip(BRIDGE_MASKS, BRIDGE_SEPARATORS):
        signs = target_signs(mask)
        values = fourier @ np.array(coefficients, dtype=np.int64)
        assert min(signs * values) == 2
        assert min(signs * ray_values) == 0
        for edge_index, edge_sign in enumerate(c5.EDGE_SIGNS.astype(np.int64)):
            assert edge_sign * coefficients[6 + edge_index] > 0

    edge_index = c5.EDGES.index(FIXED_EDGE)
    edge_sign = int(c5.EDGE_SIGNS[edge_index])
    for mask, coefficients in zip(
        BRIDGE_MASKS[1:-1], BRIDGE_UNLOCKING_SEPARATORS
    ):
        signs = target_signs(mask)
        values = fourier @ np.array(coefficients, dtype=np.int64)
        assert min(signs * values) == 2
        assert edge_sign * coefficients[6 + edge_index] < 0

    assert survey.canonical_mask(BRIDGE_MASKS[0]) == 0x1BEAD0CB
    assert survey.canonical_mask(BRIDGE_MASKS[-1]) == 0x3A8AC089


def fractions(values: np.ndarray, denominator: int = 1_000_000) -> tuple[Fraction, ...]:
    return tuple(
        Fraction(float(value)).limit_denominator(denominator) for value in values
    )


def dot(first: tuple[Fraction, ...], second: tuple[int, ...]) -> Fraction:
    return sum((value * weight for value, weight in zip(first, second)), Fraction(0))


def signed_feature_rows(signs: np.ndarray) -> tuple[tuple[int, ...], ...]:
    return tuple(
        tuple(int(value) for value in row)
        for row in signs[:, None] * c5.FOURIER.astype(np.int64)
    )


def normalize(
    coefficients: tuple[Fraction, ...],
    rows: tuple[tuple[int, ...], ...],
) -> tuple[Fraction, ...]:
    normalizer = sum((dot(coefficients, row) for row in rows), Fraction(0))
    assert normalizer > 0
    return tuple(value / normalizer for value in coefficients)


def verify_interior(
    coefficients: tuple[Fraction, ...],
    rows: tuple[tuple[int, ...], ...],
) -> None:
    assert all(dot(coefficients, row) > 0 for row in rows)
    for edge_index, edge_sign in enumerate(c5.EDGE_SIGNS.astype(np.int64)):
        assert edge_sign * coefficients[6 + edge_index] > 0


def solve_exact(
    matrix: list[list[int]], rhs: list[Fraction]
) -> list[Fraction] | None:
    """Solve a consistent rational system, setting free variables to zero."""
    row_count = len(matrix)
    column_count = len(matrix[0]) if matrix else 0
    augmented = [
        [Fraction(value) for value in row] + [rhs_value]
        for row, rhs_value in zip(matrix, rhs)
    ]
    pivot_row = 0
    pivot_columns: list[int] = []
    for column in range(column_count):
        pivot = next(
            (
                row
                for row in range(pivot_row, row_count)
                if augmented[row][column] != 0
            ),
            None,
        )
        if pivot is None:
            continue
        augmented[pivot_row], augmented[pivot] = (
            augmented[pivot],
            augmented[pivot_row],
        )
        scale = augmented[pivot_row][column]
        augmented[pivot_row] = [value / scale for value in augmented[pivot_row]]
        for row in range(row_count):
            if row == pivot_row or augmented[row][column] == 0:
                continue
            scale = augmented[row][column]
            augmented[row] = [
                value - scale * pivot_value
                for value, pivot_value in zip(augmented[row], augmented[pivot_row])
            ]
        pivot_columns.append(column)
        pivot_row += 1
        if pivot_row == row_count:
            break

    for row in augmented:
        if all(value == 0 for value in row[:-1]) and row[-1] != 0:
            return None
    solution = [Fraction(0) for _ in range(column_count)]
    for row, column in enumerate(pivot_columns):
        solution[column] = augmented[row][-1]
    return solution


def primitive_vector(coefficients: tuple[Fraction, ...]) -> tuple[int, ...]:
    common_denominator = 1
    for value in coefficients:
        common_denominator = lcm(common_denominator, value.denominator)
    integers = [
        value.numerator * (common_denominator // value.denominator)
        for value in coefficients
    ]
    common_divisor = reduce(gcd, (abs(value) for value in integers if value))
    return tuple(value // common_divisor for value in integers)


def transform_ray(
    ray: tuple[int, ...],
    permutation: tuple[int, ...],
    output_complement: bool,
    input_complement: bool,
) -> tuple[int, ...]:
    transformed = [0] * len(ray)
    output_sign = -1 if output_complement else 1
    transformed[0] = output_sign * ray[0]
    for source in range(5):
        input_sign = -1 if input_complement else 1
        transformed[1 + permutation[source]] = (
            output_sign * input_sign * ray[1 + source]
        )
    edge_index = {edge: index for index, edge in enumerate(c5.EDGES)}
    for source_index, (first, second) in enumerate(c5.EDGES):
        image = tuple(sorted((permutation[first], permutation[second])))
        transformed[6 + edge_index[image]] = output_sign * ray[6 + source_index]
    return primitive_vector(tuple(Fraction(value) for value in transformed))


def ray_orbit_key(ray: tuple[int, ...]) -> tuple[int, ...]:
    """Canonicalize under the order-40 symmetry group of the fixed C5 orthant."""
    images = []
    for permutation, exchanges_colors in survey.fixed_orthant_symmetries():
        for input_complement in (False, True):
            images.append(
                transform_ray(
                    ray,
                    permutation,
                    exchanges_colors,
                    input_complement,
                )
            )
    return min(images)


def exact_dual_certificate(
    signs: np.ndarray,
    optimizer: tuple[Fraction, ...],
    rows: tuple[tuple[int, ...], ...],
    edge: tuple[int, int],
) -> None:
    edge_index = c5.EDGES.index(edge)
    edge_sign = int(c5.EDGE_SIGNS[edge_index])
    objective = [Fraction(0) for _ in range(16)]
    objective[6 + edge_index] = Fraction(edge_sign)
    optimum = dot(optimizer, tuple(int(value) for value in objective))
    normalizer = tuple(sum(row[column] for row in rows) for column in range(16))
    target = [
        optimum * normalizer[column] - objective[column]
        for column in range(16)
    ]
    zero_vertices = [
        vertex for vertex, row in enumerate(rows) if dot(optimizer, row) == 0
    ]
    equality = np.array(
        [[rows[vertex][column] for vertex in zero_vertices] for column in range(16)],
        dtype=float,
    )
    result = linprog(
        np.zeros(len(zero_vertices)),
        A_eq=equality,
        b_eq=np.array([float(value) for value in target]),
        bounds=[(0.0, None)] * len(zero_vertices),
        method="highs",
    )
    assert result.success
    support = [index for index, value in enumerate(result.x) if value > 1e-9]
    support_vertices = [zero_vertices[index] for index in support]
    matrix = [
        [rows[vertex][column] for vertex in support_vertices]
        for column in range(16)
    ]
    weights = solve_exact(matrix, target)
    assert weights is not None and all(weight >= 0 for weight in weights)
    reconstructed = [
        sum(
            (Fraction(rows[vertex][column]) * weight for vertex, weight in zip(support_vertices, weights)),
            Fraction(0),
        )
        for column in range(16)
    ]
    assert reconstructed == target


def exact_criterion(
    coefficients: tuple[Fraction, ...], witness: dict[str, object]
) -> bool:
    negative = bool(witness["negative_orientation"])
    pivot = int(witness["pivot"])
    outside_p, outside_q = (int(value) for value in witness["outside"])
    large_a, large_b = (int(value) for value in witness["large"])
    shape_r = Fraction(float(witness["R"])).limit_denominator(1_000_000_000)
    shape_s = Fraction(float(witness["S"])).limit_denominator(1_000_000_000)
    shifted = Fraction(float(witness["Z"])).limit_denominator(1_000_000_000)
    if not (0 < shape_r < 1 < shape_s):
        return False

    matrix: dict[tuple[int, int], Fraction] = {
        (-1, index): coefficients[1 + index] / 2 for index in range(5)
    }
    matrix.update(
        {
            edge: coefficients[6 + edge_index] / 2
            for edge_index, edge in enumerate(c5.EDGES)
        }
    )

    def entry(first: int, second: int) -> Fraction:
        if first == -1:
            return matrix[(-1, second)]
        return matrix[tuple(sorted((first, second)))]

    alpha = entry(outside_p, outside_q)
    pivot_p = entry(pivot, outside_p)
    pivot_q = entry(pivot, outside_q)
    if alpha == 0 or pivot_p == 0 or pivot_q == 0:
        return False
    sigma = 1 if alpha * pivot_p * pivot_q > 0 else -1
    shape_sign = 1 if negative else -1

    def projected(target: int) -> Fraction:
        return sigma * (
            entry(-1, target)
            + shape_sign * shape_r * entry(large_a, target)
            + shape_sign * shape_s * entry(large_b, target)
        )

    h_value = projected(pivot)
    p_value = projected(outside_p)
    q_value = projected(outside_q)
    alpha_over_q = alpha / pivot_q
    alpha_over_p = alpha / pivot_p
    if not negative:
        quantities = (
            shifted + h_value,
            p_value + alpha_over_q * shifted,
            q_value + alpha_over_p * shifted,
        )
    else:
        quantities = (
            shifted - h_value,
            alpha_over_q * shifted - p_value,
            alpha_over_p * shifted - q_value,
        )
    return min(quantities) > 0


def extremal_certificate(
    mask: int,
    approximate_interior: np.ndarray,
    edge: tuple[int, int],
) -> tuple[tuple[int, ...], Fraction, dict[str, object]]:
    signs = target_signs(mask)
    rows = signed_feature_rows(signs)
    signed_features = signs[:, None] * c5.FOURIER
    edge_index = c5.EDGES.index(edge)
    edge_sign = int(c5.EDGE_SIGNS[edge_index])
    objective = np.zeros(16)
    objective[6 + edge_index] = -edge_sign
    result = linprog(
        objective,
        A_ub=-signed_features,
        b_ub=np.zeros(32),
        A_eq=np.sum(signed_features, axis=0, keepdims=True),
        b_eq=np.ones(1),
        bounds=[(None, None)] * 16,
        method="highs",
    )
    assert result.success

    optimizer = normalize(fractions(result.x), rows)
    assert all(dot(optimizer, row) >= 0 for row in rows)
    exact_dual_certificate(signs, optimizer, rows, edge)

    interior = fractions(approximate_interior)
    verify_interior(interior, rows)
    interior = normalize(interior, rows)
    verify_interior(interior, rows)

    for epsilon in EPSILONS:
        mixed = tuple(
            (1 - epsilon) * boundary + epsilon * inside
            for boundary, inside in zip(optimizer, interior)
        )
        witness = c5.criterion_witness(
            np.array([float(value) for value in mixed], dtype=float)
        )
        if witness is not None and exact_criterion(mixed, witness):
            return primitive_vector(optimizer), epsilon, witness
    raise ValueError(
        f"no exact extremal witness for mask 0x{mask:08x} and edge {edge}"
    )


def any_edge_extremal_certificate(
    mask: int, approximate_interior: np.ndarray
) -> tuple[tuple[int, ...], Fraction, dict[str, object], tuple[int, int]]:
    edge_order = (FIXED_EDGE,) + tuple(edge for edge in c5.EDGES if edge != FIXED_EDGE)
    for edge in edge_order:
        try:
            ray, epsilon, witness = extremal_certificate(
                mask, approximate_interior, edge
            )
            return ray, epsilon, witness, edge
        except ValueError:
            continue
    raise AssertionError(f"no exact edge-extremal witness for mask 0x{mask:08x}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--locked-walk", type=int, default=1000)
    parser.add_argument("--locked-class-walk", type=int, default=0)
    parser.add_argument("--incidence", type=Path)
    parser.add_argument(
        "--extra-seed",
        type=lambda value: int(value, 0),
        action="append",
        default=[],
    )
    arguments = parser.parse_args()

    verify_extreme_ray_bridge()

    if arguments.incidence:
        payload = json.loads(arguments.incidence.read_text())
        masks = sorted({mask for record in payload["incidence"] for mask in record["masks"]})
        assert len(masks) == 380
        assert len({survey.canonical_mask(mask) for mask in masks}) == 380
        walked = {}
        for mask in masks:
            interior = survey.cell_representative(target_signs(mask).astype(float))
            assert interior is not None
            walked[mask] = interior
    elif arguments.locked_class_walk:
        walked, exhausted = survey.locked_class_walk(arguments.locked_class_walk)
        assert exhausted
        for seed in arguments.extra_seed:
            extra, exhausted = survey.locked_class_walk_from_mask(
                seed, arguments.locked_class_walk
            )
            assert exhausted and not set(extra).intersection(walked)
            walked.update(extra)
    else:
        walked = survey.locked_neighbor_walk(arguments.locked_walk)
    ray_counts: Counter[tuple[int, ...]] = Counter()
    orbit_counts: Counter[tuple[int, ...]] = Counter()
    epsilon_counts: Counter[Fraction] = Counter()
    orientation_counts: Counter[bool] = Counter()
    objective_edge_counts: Counter[tuple[int, int]] = Counter()
    for index, (mask, interior) in enumerate(sorted(walked.items())):
        ray, epsilon, witness, edge = any_edge_extremal_certificate(mask, interior)
        ray_counts[ray] += 1
        orbit_counts[ray_orbit_key(ray)] += 1
        epsilon_counts[epsilon] += 1
        orientation_counts[bool(witness["negative_orientation"])] += 1
        objective_edge_counts[edge] += 1
        if (index + 1) % 100 == 0:
            print(f"exact certificates checked: {index + 1}")

    if arguments.incidence:
        print(f"archived quotient classes checked: {len(walked)}")
    elif arguments.locked_class_walk:
        print(f"locked quotient classes checked: {len(walked)}")
    else:
        print(f"locked walk cells: {len(walked)}")
    print(f"primitive optimizer rays: {len(ray_counts)}")
    print(f"optimizer ray order-40 orbits: {len(orbit_counts)}")
    print(
        "perturbation denominators: "
        f"{dict(sorted((value.denominator, count) for value, count in epsilon_counts.items()))}"
    )
    print(f"orientation counts: {dict(sorted(orientation_counts.items()))}")
    print(f"objective edge counts: {dict(sorted(objective_edge_counts.items()))}")
    if arguments.incidence:
        print("archive coverage is made exhaustive by the cocircuit tangent verifier")
    else:
        print("warning: the locked-cell walk is not exhaustive")


if __name__ == "__main__":
    main()
