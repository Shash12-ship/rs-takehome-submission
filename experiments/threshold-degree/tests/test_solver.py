from __future__ import annotations

import unittest
from fractions import Fraction
from pathlib import Path
from unittest.mock import patch

import numpy as np

from cli import load_domain
from solver import (
    BooleanDomain,
    _reconstruct_integer_dual,
    _reconstruct_integer_primal,
    find_threshold_degree,
    monomials_up_to_degree,
    signed_monomial_matrix,
)


class ThresholdDegreeTests(unittest.TestCase):
    def assert_valid_polynomial(self, domain, result):
        self.assertIsNotNone(result.polynomial)
        margins = result.polynomial.signed_margins(domain)
        self.assertTrue(np.all(margins > 0.0))
        exact_margins = result.polynomial.exact_signed_margins(domain)
        self.assertIsNotNone(exact_margins)
        self.assertTrue(np.all(exact_margins > 0))

    def assert_valid_dual(self, domain, result):
        certificate = result.lower_bound_certificate
        self.assertIsNotNone(certificate)
        monomials = monomials_up_to_degree(domain.n_bits, certificate.degree)
        features = signed_monomial_matrix(
            domain.inputs,
            monomials,
        )
        signed_features = domain.labels[:, np.newaxis] * features
        self.assertTrue(
            np.allclose(
                signed_features.T @ certificate.weights,
                0.0,
                atol=1e-8,
            )
        )
        self.assertAlmostEqual(float(np.sum(certificate.weights)), 1.0)
        self.assertTrue(np.all(certificate.weights >= -1e-8))
        self.assertLessEqual(certificate.max_orthogonality_error, 1e-8)
        self.assertLessEqual(certificate.normalization_error, 1e-8)
        self.assertGreaterEqual(certificate.min_weight, -1e-8)
        self.assertIsNotNone(certificate.integer_weights)
        exact_products = (
            signed_features.astype(object).T
            @ certificate.integer_weights.astype(object)
        )
        self.assertTrue(all(int(value) == 0 for value in exact_products))

    def test_constant_has_degree_zero(self):
        domain = BooleanDomain.from_truth_table("0000")
        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 0)
        self.assertTrue(result.is_exact)
        self.assertEqual(result.to_dict()["status"], "exact")
        self.assertIsNone(result.lower_bound_certificate)
        self.assert_valid_polynomial(domain, result)

    def test_zero_bit_constant_has_degree_zero(self):
        domain = BooleanDomain.from_truth_table("1")
        result = find_threshold_degree(domain)

        self.assertEqual(domain.inputs.shape, (1, 0))
        self.assertEqual(result.threshold_degree, 0)
        self.assert_valid_polynomial(domain, result)

    def test_and_has_degree_one(self):
        domain = BooleanDomain.from_truth_table("0001")
        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 1)
        self.assertEqual(result.lower_bound, 1)
        self.assert_valid_polynomial(domain, result)
        self.assert_valid_dual(domain, result)

    def test_xor_has_degree_two(self):
        domain = BooleanDomain.from_truth_table("0110")
        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 2)
        self.assertEqual(result.lower_bound, 2)
        self.assertTrue(result.is_exact)
        self.assertEqual(result.to_dict()["status"], "exact")
        self.assert_valid_polynomial(domain, result)
        self.assert_valid_dual(domain, result)

    def test_four_bit_parity_has_degree_four(self):
        outputs = [
            int(sum(int(bit) for bit in f"{index:04b}") % 2 == 1)
            for index in range(16)
        ]
        domain = BooleanDomain.from_truth_table(outputs)
        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 4)
        self.assert_valid_polynomial(domain, result)
        self.assert_valid_dual(domain, result)

    def test_partial_domain(self):
        domain = BooleanDomain.from_points(
            [[0, 0], [0, 1], [1, 0]],
            [0, 1, 1],
        )
        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 1)
        self.assert_valid_polynomial(domain, result)

    def test_ten_bit_separation_function_has_degree_two(self):
        inputs = np.array(
            [
                [int(bit) for bit in f"{index:010b}"]
                for index in range(1 << 10)
            ],
            dtype=np.float64,
        )
        signs = 1.0 - 2.0 * inputs
        left = signs[:, :5]
        right = signs[:, 5:]
        score = np.sum(left, axis=1) * np.sum(right, axis=1)
        score -= 3.0 * np.sum(left * right, axis=1)
        self.assertTrue(np.all(score != 0.0))
        domain = BooleanDomain.from_points(inputs, (score > 0.0).astype(np.float64))

        result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 2)
        self.assert_valid_polynomial(domain, result)
        self.assert_valid_dual(domain, result)

    def test_max_degree_returns_a_certified_lower_bound(self):
        domain = BooleanDomain.from_truth_table("0110")
        result = find_threshold_degree(domain, max_degree=1)

        self.assertIsNone(result.threshold_degree)
        self.assertEqual(result.lower_bound, 2)
        self.assertEqual(result.to_dict()["status"], "certified-lower-bound")
        self.assert_valid_dual(domain, result)

    def test_no_dual_still_reports_lp_lower_bound(self):
        domain = BooleanDomain.from_truth_table("0110")
        result = find_threshold_degree(domain, compute_dual=False)

        self.assertEqual(result.threshold_degree, 2)
        self.assertEqual(result.lower_bound, 2)
        self.assertFalse(result.is_exact)
        self.assertEqual(result.to_dict()["status"], "numerical")
        self.assertTrue(result.upper_bound_is_exact)
        self.assertFalse(result.lower_bound_is_exact)
        self.assertIsNone(result.lower_bound_certificate)

    def test_failed_integer_reconstruction_is_not_exact(self):
        domain = BooleanDomain.from_truth_table("0110")
        with (
            patch("solver._reconstruct_integer_primal", return_value=(None, None)),
            patch("solver._reconstruct_integer_dual", return_value=None),
        ):
            result = find_threshold_degree(domain)

        self.assertEqual(result.threshold_degree, 2)
        self.assertFalse(result.is_exact)
        self.assertFalse(result.upper_bound_is_exact)
        self.assertFalse(result.lower_bound_is_exact)
        self.assertEqual(result.to_dict()["status"], "numerical")
        self.assertFalse(result.polynomial.to_dict()["exact"])
        certificate_payload = result.lower_bound_certificate.to_dict(domain)
        self.assertFalse(certificate_payload["exact"])
        self.assertNotIn(
            "proves_threshold_degree_greater_than",
            certificate_payload,
        )

    def test_exact_primal_verification_uses_integer_arithmetic(self):
        primes = [999983, 999979, 999961, 999959, 999953, 999931]
        fractions = [Fraction(1, prime) for prime in primes]
        fractions += [-value for value in fractions]
        coefficients = np.array([float(value) for value in fractions])
        signed_features = np.ones((1, len(coefficients)), dtype=np.float64)

        integers, exact_min_margin = _reconstruct_integer_primal(
            signed_features,
            coefficients,
            coefficient_tolerance=1e-9,
            max_denominator=1_000_000,
        )

        self.assertIsNone(integers)
        self.assertIsNone(exact_min_margin)

    def test_exact_dual_verification_uses_integer_arithmetic(self):
        primes = [999983, 999979, 999961, 999959, 999953, 999931]
        fractions = [Fraction(1, prime) for prime in primes]
        weights = np.array([float(value) for value in fractions * 2])
        signed_features = np.array(
            [[1.0]] * len(fractions) + [[-1.0]] * len(fractions),
            dtype=np.float64,
        )

        integers = _reconstruct_integer_dual(
            signed_features,
            weights,
            coefficient_tolerance=1e-9,
            max_denominator=1_000_000,
        )

        self.assertIsNotNone(integers)
        exact_products = (
            signed_features.astype(np.int64).astype(object).T
            @ integers.astype(object)
        )
        self.assertTrue(all(int(value) == 0 for value in exact_products))

    def test_uncertified_cutoff_reports_numerical_lower_bound(self):
        domain = BooleanDomain.from_truth_table("0110")
        result = find_threshold_degree(
            domain,
            max_degree=1,
            compute_dual=False,
        )

        self.assertIsNone(result.threshold_degree)
        self.assertEqual(result.lower_bound, 2)
        self.assertFalse(result.lower_bound_is_exact)
        self.assertEqual(result.to_dict()["status"], "numerical-lower-bound")

    def test_json_input_validates_cli_n(self):
        path = Path("examples/xor.json")

        with self.assertRaisesRegex(ValueError, "JSON declares 2"):
            load_domain(path, expected_n_bits=3)

        domain = load_domain(path, expected_n_bits=2)
        self.assertEqual(domain.n_bits, 2)

    def test_rejects_non_power_of_two_truth_table(self):
        with self.assertRaisesRegex(ValueError, "power of two"):
            BooleanDomain.from_truth_table("010")


if __name__ == "__main__":
    unittest.main()
