from __future__ import annotations

import sys
import unittest
from pathlib import Path


SUBMISSION_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SUBMISSION_DIR))

import verify_hamming_threshold_family as verifier


class HammingThresholdFamilyTest(unittest.TestCase):
    def test_base_three_head_certificate(self) -> None:
        result = verifier.verify_base_three_head_certificate()
        self.assertEqual(result["minimum_signed_cleared_score"], 58)
        self.assertEqual(result["vertices_checked"], 256)

    def test_endpoint_certificates_through_six_pairs(self) -> None:
        for pairs in range(1, 7):
            margins = verifier.verify_endpoint_two_head_certificates(pairs)
            self.assertGreater(margins["threshold_1"], 0)
            self.assertGreater(margins["threshold_m"], 0)

    def test_every_hamming_threshold_has_an_xor_restriction(self) -> None:
        for pairs in range(1, 11):
            for threshold in range(1, pairs + 1):
                verifier.verify_xor_restriction(pairs, threshold)

    def test_interior_thresholds_restrict_to_four_pair_base(self) -> None:
        for pairs in range(4, 13):
            for threshold in range(2, pairs - 1):
                base = verifier.verify_interior_restriction(pairs, threshold)
                self.assertEqual(base, 2)

    def test_distance_reversal_symmetry(self) -> None:
        for pairs in range(1, 13):
            for threshold in range(1, pairs + 1):
                verifier.verify_distance_reversal_symmetry(pairs, threshold)

    def test_profile_window_patterns(self) -> None:
        self.assertEqual(
            verifier.verify_profile_window_obstruction(),
            ["00111", "11000"],
        )

    def test_family_summary(self) -> None:
        endpoint = verifier.summarize_threshold(7, 1)
        self.assertEqual(endpoint.exact_h_star, 2)

        interior = verifier.summarize_threshold(7, 4)
        self.assertEqual(interior.threshold_degree, 2)
        self.assertEqual(interior.lower_bound, 3)
        self.assertEqual(interior.upper_bound, 8)
        self.assertIsNone(interior.exact_h_star)

        near_endpoint = verifier.summarize_threshold(4, 3)
        self.assertEqual(near_endpoint.lower_bound, 2)
        self.assertIsNone(near_endpoint.exact_h_star)

        four_pair = verifier.summarize_threshold(4, 2)
        self.assertEqual(four_pair.exact_h_star, 3)


if __name__ == "__main__":
    unittest.main()
