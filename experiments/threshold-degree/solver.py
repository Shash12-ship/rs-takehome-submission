from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from itertools import combinations, product
from math import gcd, lcm
from typing import Iterable, Sequence

import numpy as np
from scipy.optimize import linprog

DEFAULT_FEASIBILITY_TOLERANCE = 1e-8
DEFAULT_COEFFICIENT_TOLERANCE = 1e-9
DEFAULT_MAX_DENOMINATOR = 1_000_000
DEFAULT_MAX_MATRIX_ENTRIES = 50_000_000


class ThresholdDegreeSolverError(RuntimeError):
    """Raised when the LP solver cannot certify feasibility or infeasibility."""


@dataclass(frozen=True)
class BooleanDomain:
    """A total or partial Boolean function written in the repository's 0/1 basis."""

    inputs: np.ndarray
    labels: np.ndarray

    @property
    def n_bits(self) -> int:
        return int(self.inputs.shape[1])

    @property
    def size(self) -> int:
        return int(self.inputs.shape[0])

    @classmethod
    def from_points(
        cls,
        inputs: Sequence[Sequence[int | bool | float]] | np.ndarray,
        outputs: Sequence[int | bool | float] | np.ndarray,
    ) -> BooleanDomain:
        input_array = np.asarray(inputs, dtype=np.float64)
        output_array = np.asarray(outputs, dtype=np.float64)

        if input_array.ndim != 2:
            raise ValueError("inputs must be a two-dimensional array")
        if output_array.ndim != 1:
            raise ValueError("outputs must be a one-dimensional array")
        if input_array.shape[0] != output_array.shape[0]:
            raise ValueError("inputs and outputs must have the same number of rows")
        if input_array.shape[0] == 0:
            raise ValueError("the Boolean domain must contain at least one point")
        if not np.all(np.isin(input_array, (0.0, 1.0))):
            raise ValueError("every input coordinate must be 0 or 1")

        rows = [tuple(int(value) for value in row) for row in input_array]
        if len(set(rows)) != len(rows):
            raise ValueError("the Boolean domain contains duplicate input points")

        output_values = set(float(value) for value in output_array)
        if output_values.issubset({0.0, 1.0}):
            labels = 2.0 * output_array - 1.0
        elif output_values.issubset({-1.0, 1.0}):
            labels = output_array.copy()
        else:
            raise ValueError("every output must be in {0, 1} or {-1, 1}")

        return cls(inputs=input_array.copy(), labels=labels)

    @classmethod
    def from_truth_table(
        cls,
        truth_table: str | Sequence[int | bool | float] | np.ndarray,
        n_bits: int | None = None,
    ) -> BooleanDomain:
        if isinstance(truth_table, str):
            if not truth_table:
                raise ValueError("the truth-table bitstring must not be empty")
            if any(bit not in "01" for bit in truth_table):
                raise ValueError("the truth-table bitstring may contain only 0 and 1")
            outputs = np.fromiter(
                (int(bit) for bit in truth_table),
                dtype=np.float64,
                count=len(truth_table),
            )
        else:
            outputs = np.asarray(truth_table, dtype=np.float64)
            if outputs.ndim != 1:
                raise ValueError("the truth table must be one-dimensional")

        inferred_n_bits = _log2_exact(len(outputs))
        if n_bits is None:
            n_bits = inferred_n_bits
        elif n_bits != inferred_n_bits:
            raise ValueError(
                f"a {n_bits}-bit truth table must contain {1 << n_bits} values, "
                f"not {len(outputs)}"
            )

        return cls.from_points(all_boolean_inputs(n_bits), outputs)


@dataclass(frozen=True)
class PolynomialWitness:
    """A degree-bounded polynomial that strictly sign-represents a Boolean function."""

    degree: int
    monomials: tuple[tuple[int, ...], ...]
    coefficients: np.ndarray
    min_signed_margin: float
    integer_coefficients: np.ndarray | None = None
    exact_min_signed_margin: int | None = None

    @property
    def is_exact(self) -> bool:
        return (
            self.integer_coefficients is not None
            and self.exact_min_signed_margin is not None
            and self.exact_min_signed_margin > 0
        )

    def evaluate(self, inputs: np.ndarray) -> np.ndarray:
        features = signed_monomial_matrix(inputs, self.monomials)
        return features @ self.coefficients

    def signed_margins(self, domain: BooleanDomain) -> np.ndarray:
        return domain.labels * self.evaluate(domain.inputs)

    def exact_signed_margins(self, domain: BooleanDomain) -> np.ndarray | None:
        if self.integer_coefficients is None:
            return None
        features = signed_monomial_matrix(
            domain.inputs,
            self.monomials,
            dtype=np.int64,
        )
        return domain.labels.astype(np.int64) * (
            features @ self.integer_coefficients
        )

    def to_dict(self, coefficient_tolerance: float = DEFAULT_COEFFICIENT_TOLERANCE) -> dict:
        terms = []
        for index, (monomial, coefficient) in enumerate(
            zip(self.monomials, self.coefficients)
        ):
            integer_coefficient = (
                None
                if self.integer_coefficients is None
                else int(self.integer_coefficients[index])
            )
            if (
                abs(float(coefficient)) <= coefficient_tolerance
                and integer_coefficient in (None, 0)
            ):
                continue
            term = {
                "variables": list(monomial),
                "coefficient": float(coefficient),
            }
            if integer_coefficient is not None:
                term["integer_coefficient"] = integer_coefficient
            terms.append(term)

        payload = {
            "basis": "signed characters s_i = 1 - 2*x_i",
            "degree": self.degree,
            "exact": self.is_exact,
            "min_signed_margin": self.min_signed_margin,
            "terms": terms,
        }
        if self.exact_min_signed_margin is not None:
            payload["exact_min_signed_margin"] = self.exact_min_signed_margin
        return payload


@dataclass(frozen=True)
class DualCertificate:
    """A nonnegative witness orthogonal to all monomials through a given degree."""

    degree: int
    weights: np.ndarray
    max_orthogonality_error: float
    normalization_error: float
    min_weight: float
    integer_weights: np.ndarray | None = None

    @property
    def is_exact(self) -> bool:
        return self.integer_weights is not None

    @property
    def support(self) -> np.ndarray:
        if self.integer_weights is not None:
            return np.flatnonzero(self.integer_weights)
        return np.flatnonzero(self.weights > DEFAULT_COEFFICIENT_TOLERANCE)

    def to_dict(
        self,
        domain: BooleanDomain | None = None,
        weight_tolerance: float = DEFAULT_COEFFICIENT_TOLERANCE,
    ) -> dict:
        support = []
        for index, weight in enumerate(self.weights):
            integer_weight = (
                None if self.integer_weights is None else int(self.integer_weights[index])
            )
            if float(weight) <= weight_tolerance and integer_weight in (None, 0):
                continue
            item = {
                "point_index": index,
                "weight": float(weight),
            }
            if integer_weight is not None:
                item["integer_weight"] = integer_weight
            if domain is not None:
                item["input"] = "".join(
                    str(int(value)) for value in domain.inputs[index]
                )
                item["output"] = int(domain.labels[index] > 0)
            support.append(item)

        payload = {
            "degree": self.degree,
            "exact": self.is_exact,
            "max_orthogonality_error": self.max_orthogonality_error,
            "normalization_error": self.normalization_error,
            "min_weight": self.min_weight,
            "support": support,
        }
        if self.is_exact:
            payload["proves_threshold_degree_greater_than"] = self.degree
        else:
            payload["numerically_supports_threshold_degree_greater_than"] = self.degree
        return payload


@dataclass(frozen=True)
class DegreeCheck:
    degree: int
    feasible: bool
    solver_message: str
    polynomial: PolynomialWitness | None = None
    dual: DualCertificate | None = None

    def to_dict(self) -> dict:
        return {
            "degree": self.degree,
            "feasible": self.feasible,
            "solver_message": self.solver_message,
        }


@dataclass(frozen=True)
class ThresholdDegreeResult:
    domain: BooleanDomain
    threshold_degree: int | None
    searched_through_degree: int
    checks: tuple[DegreeCheck, ...]
    polynomial: PolynomialWitness | None
    lower_bound_certificate: DualCertificate | None

    @property
    def upper_bound_is_exact(self) -> bool:
        return self.polynomial is not None and self.polynomial.is_exact

    @property
    def lower_bound_is_exact(self) -> bool:
        if self.lower_bound == 0:
            return True
        return (
            self.lower_bound_certificate is not None
            and self.lower_bound_certificate.is_exact
        )

    @property
    def is_exact(self) -> bool:
        return (
            self.threshold_degree is not None
            and self.upper_bound_is_exact
            and self.lower_bound_is_exact
        )

    @property
    def lower_bound(self) -> int:
        if self.threshold_degree is not None:
            return self.threshold_degree
        return self.searched_through_degree + 1

    def to_dict(self) -> dict:
        if self.is_exact:
            status = "exact"
        elif self.threshold_degree is not None:
            status = "numerical"
        elif self.lower_bound_is_exact:
            status = "certified-lower-bound"
        else:
            status = "numerical-lower-bound"

        payload = {
            "status": status,
            "upper_bound_certified": self.upper_bound_is_exact,
            "lower_bound_certified": self.lower_bound_is_exact,
            "n_bits": self.domain.n_bits,
            "domain_size": self.domain.size,
            "threshold_degree": self.threshold_degree,
            "lower_bound": self.lower_bound,
            "searched_through_degree": self.searched_through_degree,
            "checks": [check.to_dict() for check in self.checks],
        }
        if self.polynomial is not None:
            payload["polynomial"] = self.polynomial.to_dict()
        if self.lower_bound_certificate is not None:
            payload["lower_bound_certificate"] = (
                self.lower_bound_certificate.to_dict(self.domain)
            )
        return payload


def monomials_up_to_degree(
    n_bits: int,
    degree: int,
) -> tuple[tuple[int, ...], ...]:
    if n_bits < 0:
        raise ValueError("n_bits must be nonnegative")
    if not 0 <= degree <= n_bits:
        raise ValueError(f"degree must satisfy 0 <= degree <= {n_bits}")
    return tuple(
        monomial
        for size in range(degree + 1)
        for monomial in combinations(range(n_bits), size)
    )


def all_boolean_inputs(n_bits: int) -> np.ndarray:
    """Return all 0/1 inputs in lexicographic order."""
    if n_bits < 0:
        raise ValueError("n_bits must be nonnegative")
    if n_bits == 0:
        return np.empty((1, 0), dtype=np.float64)
    return np.array(
        list(product([0.0, 1.0], repeat=n_bits)),
        dtype=np.float64,
    ).reshape(-1, n_bits)


def signed_monomial_matrix(
    inputs: Sequence[Sequence[int | bool | float]] | np.ndarray,
    monomials: Iterable[tuple[int, ...]],
    *,
    dtype=np.float64,
) -> np.ndarray:
    input_array = np.asarray(inputs, dtype=np.float64)
    if input_array.ndim != 2:
        raise ValueError("inputs must be a two-dimensional array")
    if not np.all(np.isin(input_array, (0.0, 1.0))):
        raise ValueError("every input coordinate must be 0 or 1")

    monomial_tuple = tuple(monomials)
    signs = 1.0 - 2.0 * input_array
    matrix = np.ones((input_array.shape[0], len(monomial_tuple)), dtype=dtype)
    for column, monomial in enumerate(monomial_tuple):
        if monomial:
            matrix[:, column] = np.prod(signs[:, monomial], axis=1)
    return matrix


def check_degree(
    domain: BooleanDomain,
    degree: int,
    *,
    compute_dual: bool = True,
    feasibility_tolerance: float = DEFAULT_FEASIBILITY_TOLERANCE,
    coefficient_tolerance: float = DEFAULT_COEFFICIENT_TOLERANCE,
    max_denominator: int = DEFAULT_MAX_DENOMINATOR,
    max_matrix_entries: int | None = DEFAULT_MAX_MATRIX_ENTRIES,
) -> DegreeCheck:
    _validate_degree_and_size(
        domain,
        degree,
        max_matrix_entries=max_matrix_entries,
    )
    monomials = monomials_up_to_degree(domain.n_bits, degree)
    features = signed_monomial_matrix(domain.inputs, monomials)
    signed_features = domain.labels[:, np.newaxis] * features

    primal = linprog(
        c=np.zeros(len(monomials), dtype=np.float64),
        A_ub=-signed_features,
        b_ub=-np.ones(domain.size, dtype=np.float64),
        bounds=[(None, None)] * len(monomials),
        method="highs",
    )

    if primal.status == 0:
        coefficients = np.asarray(primal.x, dtype=np.float64)
        coefficients[np.abs(coefficients) <= coefficient_tolerance] = 0.0
        margins = signed_features @ coefficients
        min_margin = float(np.min(margins))
        if min_margin <= feasibility_tolerance:
            raise ThresholdDegreeSolverError(
                "HiGHS reported feasibility, but the returned polynomial "
                f"has minimum signed margin {min_margin}"
            )

        coefficients = coefficients / min_margin
        integer_coefficients, exact_min_margin = _reconstruct_integer_primal(
            signed_features,
            coefficients,
            coefficient_tolerance=coefficient_tolerance,
            max_denominator=max_denominator,
        )
        polynomial = PolynomialWitness(
            degree=degree,
            monomials=monomials,
            coefficients=coefficients,
            min_signed_margin=float(np.min(signed_features @ coefficients)),
            integer_coefficients=integer_coefficients,
            exact_min_signed_margin=exact_min_margin,
        )
        return DegreeCheck(
            degree=degree,
            feasible=True,
            solver_message=primal.message,
            polynomial=polynomial,
        )

    if primal.status != 2:
        raise ThresholdDegreeSolverError(
            f"HiGHS could not decide degree {degree}: {primal.message}"
        )

    dual = None
    if compute_dual:
        dual = _solve_dual_certificate(
            signed_features,
            degree=degree,
            feasibility_tolerance=feasibility_tolerance,
            coefficient_tolerance=coefficient_tolerance,
            max_denominator=max_denominator,
        )
    return DegreeCheck(
        degree=degree,
        feasible=False,
        solver_message=primal.message,
        dual=dual,
    )


def find_threshold_degree(
    domain: BooleanDomain,
    *,
    max_degree: int | None = None,
    compute_dual: bool = True,
    feasibility_tolerance: float = DEFAULT_FEASIBILITY_TOLERANCE,
    coefficient_tolerance: float = DEFAULT_COEFFICIENT_TOLERANCE,
    max_denominator: int = DEFAULT_MAX_DENOMINATOR,
    max_matrix_entries: int | None = DEFAULT_MAX_MATRIX_ENTRIES,
) -> ThresholdDegreeResult:
    if max_degree is None:
        max_degree = domain.n_bits
    if not 0 <= max_degree <= domain.n_bits:
        raise ValueError(
            f"max_degree must satisfy 0 <= max_degree <= {domain.n_bits}"
        )

    checks = []
    polynomial = None
    for degree in range(max_degree + 1):
        check = check_degree(
            domain,
            degree,
            compute_dual=False,
            feasibility_tolerance=feasibility_tolerance,
            coefficient_tolerance=coefficient_tolerance,
            max_denominator=max_denominator,
            max_matrix_entries=max_matrix_entries,
        )
        checks.append(check)
        if check.feasible:
            polynomial = check.polynomial
            break

    threshold_degree = None if polynomial is None else polynomial.degree
    lower_bound_certificate = None
    if compute_dual:
        if threshold_degree is None:
            certificate_degree = max_degree
        else:
            certificate_degree = threshold_degree - 1
        if certificate_degree >= 0:
            lower_check = check_degree(
                domain,
                certificate_degree,
                compute_dual=True,
                feasibility_tolerance=feasibility_tolerance,
                coefficient_tolerance=coefficient_tolerance,
                max_denominator=max_denominator,
                max_matrix_entries=max_matrix_entries,
            )
            if lower_check.feasible or lower_check.dual is None:
                raise ThresholdDegreeSolverError(
                    f"failed to construct the degree-{certificate_degree} "
                    "lower-bound certificate"
                )
            lower_bound_certificate = lower_check.dual

    return ThresholdDegreeResult(
        domain=domain,
        threshold_degree=threshold_degree,
        searched_through_degree=checks[-1].degree,
        checks=tuple(checks),
        polynomial=polynomial,
        lower_bound_certificate=lower_bound_certificate,
    )


def _solve_dual_certificate(
    signed_features: np.ndarray,
    *,
    degree: int,
    feasibility_tolerance: float,
    coefficient_tolerance: float,
    max_denominator: int,
) -> DualCertificate:
    domain_size = signed_features.shape[0]
    equality_matrix = np.vstack(
        (
            signed_features.T,
            np.ones((1, domain_size), dtype=np.float64),
        )
    )
    equality_rhs = np.concatenate(
        (
            np.zeros(signed_features.shape[1], dtype=np.float64),
            np.ones(1, dtype=np.float64),
        )
    )
    dual = linprog(
        c=np.zeros(domain_size, dtype=np.float64),
        A_eq=equality_matrix,
        b_eq=equality_rhs,
        bounds=(0.0, None),
        method="highs",
    )
    if dual.status != 0:
        raise ThresholdDegreeSolverError(
            f"HiGHS could not construct the degree-{degree} dual certificate: "
            f"{dual.message}"
        )

    weights = np.asarray(dual.x, dtype=np.float64)
    weights[np.abs(weights) <= coefficient_tolerance] = 0.0
    orthogonality = signed_features.T @ weights
    max_error = float(np.max(np.abs(orthogonality)))
    normalization_error = abs(float(np.sum(weights)) - 1.0)
    min_weight = float(np.min(weights))
    if (
        max_error > feasibility_tolerance
        or normalization_error > feasibility_tolerance
        or min_weight < -feasibility_tolerance
    ):
        raise ThresholdDegreeSolverError(
            "HiGHS returned an invalid dual certificate: "
            f"orthogonality error {max_error}, "
            f"normalization error {normalization_error}, "
            f"minimum weight {min_weight}"
        )

    integer_weights = _reconstruct_integer_dual(
        signed_features,
        weights,
        coefficient_tolerance=coefficient_tolerance,
        max_denominator=max_denominator,
    )
    return DualCertificate(
        degree=degree,
        weights=weights,
        max_orthogonality_error=max_error,
        normalization_error=normalization_error,
        min_weight=min_weight,
        integer_weights=integer_weights,
    )


def _reconstruct_integer_primal(
    signed_features: np.ndarray,
    coefficients: np.ndarray,
    *,
    coefficient_tolerance: float,
    max_denominator: int,
) -> tuple[np.ndarray | None, int | None]:
    fractions = [
        Fraction(0)
        if abs(float(value)) <= coefficient_tolerance
        else Fraction(float(value)).limit_denominator(max_denominator)
        for value in coefficients
    ]
    integers = _fractions_to_primitive_integers(fractions)
    integer_signed_features = signed_features.astype(np.int64).astype(object)
    exact_margins = integer_signed_features @ integers.astype(object)
    if any(int(margin) <= 0 for margin in exact_margins):
        return None, None
    return integers, min(int(margin) for margin in exact_margins)


def _reconstruct_integer_dual(
    signed_features: np.ndarray,
    weights: np.ndarray,
    *,
    coefficient_tolerance: float,
    max_denominator: int,
) -> np.ndarray | None:
    fractions = [
        Fraction(0)
        if float(value) <= coefficient_tolerance
        else Fraction(float(value)).limit_denominator(max_denominator)
        for value in weights
    ]
    integers = _fractions_to_primitive_integers(fractions)
    if np.any(integers < 0) or not np.any(integers > 0):
        return None
    integer_signed_features = signed_features.astype(np.int64).astype(object)
    exact_products = integer_signed_features.T @ integers.astype(object)
    if any(int(value) != 0 for value in exact_products):
        return None
    return integers


def _fractions_to_primitive_integers(
    values: Sequence[Fraction],
) -> np.ndarray:
    denominator_lcm = 1
    for value in values:
        denominator_lcm = lcm(denominator_lcm, value.denominator)
    integers = [
        value.numerator * (denominator_lcm // value.denominator)
        for value in values
    ]
    common_divisor = 0
    for value in integers:
        common_divisor = gcd(common_divisor, abs(value))
    if common_divisor > 1:
        integers = [value // common_divisor for value in integers]
    return np.asarray(integers, dtype=object)


def _validate_degree_and_size(
    domain: BooleanDomain,
    degree: int,
    *,
    max_matrix_entries: int | None,
) -> None:
    monomial_count = len(monomials_up_to_degree(domain.n_bits, degree))
    matrix_entries = domain.size * monomial_count
    if max_matrix_entries is not None and matrix_entries > max_matrix_entries:
        raise ValueError(
            f"degree {degree} requires a dense {domain.size} by {monomial_count} "
            f"matrix with {matrix_entries} entries, exceeding the configured "
            f"limit of {max_matrix_entries}"
        )


def _log2_exact(value: int) -> int:
    if value <= 0:
        raise ValueError("the truth table must contain at least one value")
    n_bits = value.bit_length() - 1
    if 1 << n_bits != value:
        raise ValueError("the truth-table length must be a power of two")
    return n_bits
