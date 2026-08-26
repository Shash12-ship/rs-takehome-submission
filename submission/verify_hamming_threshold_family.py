#!/usr/bin/env python3
"""Exact verification for the Hamming-threshold family result.

The mathematical proof has three ingredients:

1. Every Hamming-distance threshold has threshold degree exactly two because
   its defining polynomial is quadratic and it has a two-bit XOR restriction.
2. The two endpoint thresholds are equality/inequality after input or output
   complementation, so the repository's two-head equality construction applies.
3. Every threshold with 2 <= t <= m-2 restricts to the exact four-pair
   separation HDTH(4, 2).

This script checks the finite identities behind all three steps. It also
re-verifies the archived three-head certificate for HDTH(4, 2) using integer
arithmetic. The script does not use numerical optimization.
"""

from __future__ import annotations

import argparse
import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Iterable


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
BASE_CERTIFICATE = (
    REPOSITORY_ROOT
    / "artifacts"
    / "calculations"
    / "f8_three_head_upper_search.json"
)


@dataclass(frozen=True)
class ThresholdSummary:
    pairs: int
    threshold: int
    threshold_degree: int
    lower_bound: int
    upper_bound: int
    exact_h_star: int | None
    lower_bound_reason: str


def bit_tuple(code: int, width: int) -> tuple[int, ...]:
    """Return the little-endian Boolean tuple represented by ``code``."""

    return tuple((code >> index) & 1 for index in range(width))


def hamming_distance(left: Iterable[int], right: Iterable[int]) -> int:
    return sum(a != b for a, b in zip(left, right))


def hdth(left: tuple[int, ...], right: tuple[int, ...], threshold: int) -> bool:
    return hamming_distance(left, right) >= threshold


def affine(coefficients: list[int], point: tuple[int, ...]) -> int:
    if len(coefficients) != len(point) + 1:
        raise ValueError("An affine coefficient row must contain a constant term.")
    return coefficients[0] + sum(
        coefficient * coordinate
        for coefficient, coordinate in zip(coefficients[1:], point)
    )


def verify_quadratic_sign_representation(pairs: int, threshold: int) -> None:
    """Check that 2*Delta-(2t-1) has exactly the target strict signs."""

    for distance in range(pairs + 1):
        doubled_score = 2 * distance - (2 * threshold - 1)
        assert doubled_score != 0
        assert (doubled_score > 0) == (distance >= threshold)


def verify_xor_restriction(pairs: int, threshold: int) -> None:
    """Check the restriction proving threshold degree at least two.

    Fix ``threshold - 1`` pairs to be unequal, leave one pair free, and
    fix every remaining pair to be equal. The threshold is then XOR on the
    free pair.
    """

    fixed_unequal = threshold - 1
    fixed_equal = pairs - threshold
    assert fixed_unequal >= 0 and fixed_equal >= 0
    assert fixed_unequal + 1 + fixed_equal == pairs

    for free_left in (0, 1):
        for free_right in (0, 1):
            left = (0,) * fixed_unequal + (free_left,) + (0,) * fixed_equal
            right = (1,) * fixed_unequal + (free_right,) + (0,) * fixed_equal
            assert hdth(left, right, threshold) == (free_left != free_right)


def equality_two_head_cleared_score(
    left: tuple[int, ...], right: tuple[int, ...]
) -> int:
    """Return an integer multiple of the thresholded two-head equality score.

    With binary encodings X and Y, the repository's two-head score has
    cleared numerator P = 1-(X-Y)^2 and positive denominator B1*B2. Its
    classification threshold is 1/(2K), where
    K=(1+2N)(1+3N) and N=2^m-1. Hence

        2K*P - B1*B2

    has the strict signs of equality and can be checked with integers only.
    """

    if len(left) != len(right):
        raise ValueError("The strings must have the same length.")
    pairs = len(left)
    x_value = sum(bit << index for index, bit in enumerate(left))
    y_value = sum(bit << index for index, bit in enumerate(right))
    maximum = (1 << pairs) - 1

    denominator_1 = 1 + x_value + y_value
    denominator_2 = 1 + x_value + 2 * y_value
    cleared_numerator = 1 - (x_value - y_value) ** 2
    scale = (1 + 2 * maximum) * (1 + 3 * maximum)
    return 2 * scale * cleared_numerator - denominator_1 * denominator_2


def antipodal_two_head_cleared_score(
    left: tuple[int, ...], right: tuple[int, ...]
) -> int:
    """Return the cleared two-head score for distance exactly ``m``.

    Let X and Y be binary encodings and N=2^m-1. The strings are bitwise
    opposite exactly when X+Y=N. The score

        -1 + d1/(Z+1) + d2/(Z+2),

    where Z=X+Y, d1=-(N+1/2)(N+3/2), and
    d2=(N+3/2)(N+5/2), clears to 1/4-(Z-N)^2. Multiplying by four gives the
    integer returned here. Both denominators have positive orientation.
    """

    if len(left) != len(right):
        raise ValueError("The strings must have the same length.")
    pairs = len(left)
    x_value = sum(bit << index for index, bit in enumerate(left))
    y_value = sum(bit << index for index, bit in enumerate(right))
    maximum = (1 << pairs) - 1
    statistic = x_value + y_value

    coefficient_1 = -(4 * maximum**2 + 8 * maximum + 3)
    coefficient_2 = 4 * maximum**2 + 16 * maximum + 15
    cleared_from_atoms = (
        -4 * (statistic + 1) * (statistic + 2)
        + coefficient_1 * (statistic + 2)
        + coefficient_2 * (statistic + 1)
    )
    direct = 1 - 4 * (statistic - maximum) ** 2
    assert cleared_from_atoms == direct
    return direct


def verify_endpoint_two_head_certificates(pairs: int) -> dict[str, int]:
    """Exhaustively check exact two-head certificates for t=1 and t=m."""

    minimum_signed_scores = {"threshold_1": None, "threshold_m": None}
    for left_code in range(1 << pairs):
        left = bit_tuple(left_code, pairs)
        for right_code in range(1 << pairs):
            right = bit_tuple(right_code, pairs)

            equality_score = equality_two_head_cleared_score(left, right)
            equality_sign = 1 if left == right else -1
            assert equality_sign * equality_score > 0

            # HDTH(m,1) is non-equality, so negate the equality score.
            threshold_1_sign = 1 if hdth(left, right, 1) else -1
            signed_1 = threshold_1_sign * (-equality_score)
            assert signed_1 > 0

            # HDTH(m,m) is the positive affine level set X+Y=2^m-1.
            antipodal_equality_score = antipodal_two_head_cleared_score(left, right)
            threshold_m_sign = 1 if hdth(left, right, pairs) else -1
            signed_m = threshold_m_sign * antipodal_equality_score
            assert signed_m > 0

            old_1 = minimum_signed_scores["threshold_1"]
            old_m = minimum_signed_scores["threshold_m"]
            minimum_signed_scores["threshold_1"] = (
                signed_1 if old_1 is None else min(old_1, signed_1)
            )
            minimum_signed_scores["threshold_m"] = (
                signed_m if old_m is None else min(old_m, signed_m)
            )

    return {
        name: int(value) for name, value in minimum_signed_scores.items()
        if value is not None
    }


def verify_distance_reversal_symmetry(pairs: int, threshold: int) -> None:
    """Check g_t(x,1-y) = 1-g_{m-t+1}(x,y) at the profile level."""

    reflected_threshold = pairs - threshold + 1
    for distance in range(pairs + 1):
        left = distance >= threshold
        reflected = (pairs - distance) >= reflected_threshold
        assert left == (not reflected)


def verify_interior_restriction(pairs: int, threshold: int) -> int:
    """Check a threshold restriction to HDTH(4,2).

    Returns the threshold of the four-pair base function used by the
    restriction.
    """

    if pairs < 4 or not 2 <= threshold <= pairs - 2:
        raise ValueError("Restriction requires m >= 4 and 2 <= t <= m-2.")

    fixed_unequal = threshold - 2
    base_threshold = 2
    fixed_equal = pairs - fixed_unequal - 4
    assert fixed_unequal >= 0 and fixed_equal >= 0

    for left_code in range(1 << 4):
        free_left = bit_tuple(left_code, 4)
        for right_code in range(1 << 4):
            free_right = bit_tuple(right_code, 4)
            left = (0,) * fixed_unequal + free_left + (0,) * fixed_equal
            right = (1,) * fixed_unequal + free_right + (0,) * fixed_equal
            assert hdth(left, right, threshold) == hdth(
                free_left, free_right, base_threshold
            )
    return base_threshold


def verify_profile_window_obstruction() -> list[str]:
    """Enumerate the windows covered by the base obstruction and complement."""

    base_patterns = {tuple(int(distance >= 2) for distance in range(5))}
    patterns = base_patterns | {
        tuple(1 - label for label in pattern) for pattern in base_patterns
    }
    expected = {"00111", "11000"}
    encoded = {"".join(map(str, pattern)) for pattern in patterns}
    assert encoded == expected
    return sorted(encoded)


def verify_base_three_head_certificate() -> dict[str, object]:
    """Re-check the archived HDTH(4,2) upper certificate over the integers."""

    payload = json.loads(BASE_CERTIFICATE.read_text(encoding="utf-8"))
    certificate = payload["certificate"]
    if certificate is None:
        raise ValueError("The archived base certificate is missing.")

    denominators = [list(map(int, row)) for row in certificate["denominators"]]
    coefficients = list(map(int, certificate["score_coefficients"]))
    heads = 3
    input_bits = 8
    width = input_bits + 1
    assert certificate["orientations"] == [-1, -1, -1]
    assert len(denominators) == heads
    assert all(len(row) == width for row in denominators)
    assert len(coefficients) == 1 + heads * width

    constant = coefficients[0]
    numerators = [
        coefficients[1 + head * width : 1 + (head + 1) * width]
        for head in range(heads)
    ]
    assert all(all(slope < 0 for slope in row[1:]) for row in denominators)

    ranges = [[] for _ in range(heads)]
    signed_scores: list[int] = []
    for code in range(1 << input_bits):
        point = bit_tuple(code, input_bits)
        left, right = point[:4], point[4:]
        target_sign = 1 if hdth(left, right, 2) else -1
        denominator_values = [affine(row, point) for row in denominators]
        assert all(value > 0 for value in denominator_values)
        for head, value in enumerate(denominator_values):
            ranges[head].append(value)
        numerator_values = [affine(row, point) for row in numerators]

        cleared_score = constant
        for value in denominator_values:
            cleared_score *= value
        for head in range(heads):
            other_product = 1
            for other in range(heads):
                if other != head:
                    other_product *= denominator_values[other]
            cleared_score += numerator_values[head] * other_product
        signed_scores.append(target_sign * cleared_score)

    denominator_ranges = [(min(row), max(row)) for row in ranges]
    minimum_margin = min(signed_scores)
    assert denominator_ranges == [(14, 34), (1, 31), (6, 32)]
    assert minimum_margin == certificate["minimum_signed_cleared_score"] == 58
    assert all(score > 0 for score in signed_scores)
    return {
        "denominator_ranges": denominator_ranges,
        "minimum_signed_cleared_score": minimum_margin,
        "vertices_checked": 1 << input_bits,
    }


def summarize_threshold(pairs: int, threshold: int) -> ThresholdSummary:
    verify_quadratic_sign_representation(pairs, threshold)
    verify_xor_restriction(pairs, threshold)
    verify_distance_reversal_symmetry(pairs, threshold)

    if threshold in (1, pairs):
        return ThresholdSummary(
            pairs=pairs,
            threshold=threshold,
            threshold_degree=2,
            lower_bound=2,
            upper_bound=2,
            exact_h_star=2,
            lower_bound_reason="XOR restriction; matching equality certificate",
        )

    if threshold == pairs - 1:
        return ThresholdSummary(
            pairs=pairs,
            threshold=threshold,
            threshold_degree=2,
            lower_bound=2,
            upper_bound=pairs + 1,
            exact_h_star=None,
            lower_bound_reason="XOR restriction; the four-pair lift does not apply",
        )

    base_threshold = verify_interior_restriction(pairs, threshold)
    exact = 3 if pairs == 4 and threshold == 2 else None
    return ThresholdSummary(
        pairs=pairs,
        threshold=threshold,
        threshold_degree=2,
        lower_bound=3,
        upper_bound=3 if exact == 3 else pairs + 1,
        exact_h_star=exact,
        lower_bound_reason=f"restriction to HDTH(4,{base_threshold})",
    )


def run(max_pairs: int, exhaustive_endpoints_through: int) -> dict[str, object]:
    if max_pairs < 4:
        raise ValueError("--max-pairs must be at least 4.")
    if not 1 <= exhaustive_endpoints_through <= max_pairs:
        raise ValueError(
            "--exhaustive-endpoints-through must lie between 1 and --max-pairs."
        )

    base_certificate = verify_base_three_head_certificate()
    profile_windows = verify_profile_window_obstruction()

    endpoint_certificates = {}
    for pairs in range(1, exhaustive_endpoints_through + 1):
        endpoint_certificates[str(pairs)] = verify_endpoint_two_head_certificates(pairs)

    summaries = []
    for pairs in range(4, max_pairs + 1):
        for threshold in range(1, pairs + 1):
            summaries.append(asdict(summarize_threshold(pairs, threshold)))

    return {
        "status": "all exact finite checks passed",
        "claim": (
            "For m>=4, deg_pm(HDTH(m,t))=2 for all t; H*=2 at t in "
            "{1,m}; and H*>=3 for every 2<=t<=m-2. The t=m-1 case "
            "is not resolved by this argument."
        ),
        "base_three_head_certificate": base_certificate,
        "profile_window_obstruction_patterns": profile_windows,
        "endpoint_certificate_minimum_margins": endpoint_certificates,
        "summaries": summaries,
    }


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Exactly verify the Hamming-threshold family result."
    )
    parser.add_argument(
        "--max-pairs",
        type=int,
        default=10,
        help="Largest m for which to check the symbolic restriction identities.",
    )
    parser.add_argument(
        "--exhaustive-endpoints-through",
        type=int,
        default=8,
        help=(
            "Largest m for exhaustive truth-table checks of the endpoint two-head "
            "certificates. Runtime grows as 4^m."
        ),
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Optional path for a JSON verification report.",
    )
    return parser


def main() -> None:
    args = build_parser().parse_args()
    report = run(args.max_pairs, args.exhaustive_endpoints_through)
    rendered = json.dumps(report, indent=2)
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered + "\n", encoding="utf-8")
    print(rendered)


if __name__ == "__main__":
    main()
