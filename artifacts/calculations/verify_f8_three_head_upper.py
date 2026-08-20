#!/usr/bin/env python3
"""Verify the archived exact three-head upper bound for HDTH4."""

from __future__ import annotations

import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ARCHIVE = HERE / "f8_three_head_upper_search.json"
INPUT_BITS = 8
BLOCK_BITS = 4
HEADS = 3
WIDTH = INPUT_BITS + 1


def bits(code: int) -> tuple[int, ...]:
    return tuple((code >> index) & 1 for index in range(INPUT_BITS))


def affine(coefficients: list[int], point: tuple[int, ...]) -> int:
    assert len(coefficients) == WIDTH
    return coefficients[0] + sum(
        coefficient * coordinate
        for coefficient, coordinate in zip(coefficients[1:], point)
    )


def target_sign(point: tuple[int, ...]) -> int:
    distance = sum(
        point[index] != point[index + BLOCK_BITS]
        for index in range(BLOCK_BITS)
    )
    return 1 if distance >= 2 else -1


def main() -> None:
    payload = json.loads(ARCHIVE.read_text())
    assert payload["dimension"] == INPUT_BITS
    certificate = payload["certificate"]
    assert certificate is not None
    denominators = [list(map(int, row)) for row in certificate["denominators"]]
    coefficients = list(map(int, certificate["score_coefficients"]))
    assert len(denominators) == HEADS
    assert all(len(row) == WIDTH for row in denominators)
    assert len(coefficients) == 1 + HEADS * WIDTH
    assert certificate["orientations"] == [-1, -1, -1]

    constant = coefficients[0]
    numerators = [
        coefficients[1 + head * WIDTH : 1 + (head + 1) * WIDTH]
        for head in range(HEADS)
    ]
    for denominator in denominators:
        assert all(value < 0 for value in denominator[1:])

    denominator_values = [[] for _ in range(HEADS)]
    signed_cleared_scores = []
    truth_mask = 0
    for code in range(1 << INPUT_BITS):
        point = bits(code)
        sign = target_sign(point)
        if sign > 0:
            truth_mask |= 1 << code
        current_denominators = [affine(row, point) for row in denominators]
        assert all(value > 0 for value in current_denominators)
        for head, value in enumerate(current_denominators):
            denominator_values[head].append(value)
        current_numerators = [affine(row, point) for row in numerators]
        cleared = constant
        for value in current_denominators:
            cleared *= value
        for head in range(HEADS):
            other_product = 1
            for other in range(HEADS):
                if other != head:
                    other_product *= current_denominators[other]
            cleared += current_numerators[head] * other_product
        signed_cleared_scores.append(sign * cleared)

    ranges = [
        (min(values), max(values)) for values in denominator_values
    ]
    assert ranges == [(14, 34), (1, 31), (6, 32)]
    minimum = min(signed_cleared_scores)
    assert minimum == certificate["minimum_signed_cleared_score"] == 58
    assert all(value > 0 for value in signed_cleared_scores)

    print("input bits:", INPUT_BITS)
    print("truth-table points:", 1 << INPUT_BITS)
    print("truth mask:", f"0x{truth_mask:064x}")
    print("denominator ranges:", ranges)
    print("minimum signed cleared score:", minimum)
    print("three-head certificate: verified")


if __name__ == "__main__":
    main()
