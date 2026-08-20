from __future__ import annotations

import argparse
import json
from pathlib import Path

from .config import SearchConfig, TrainingConfig
from .search import run_representative_search


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Enumerate safe symmetry representatives and estimate H*(f)."
    )
    parser.add_argument("--n", type=int, required=True, help="Number of input bits.")
    parser.add_argument(
        "--max-heads",
        type=int,
        required=True,
        help="Maximum number of heads to try in the experimental search.",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=None,
        help="Optional limit on the number of representatives to process.",
    )
    parser.add_argument(
        "--start-index",
        type=int,
        default=0,
        help="Inclusive start index into the representative list.",
    )
    parser.add_argument(
        "--end-index",
        type=int,
        default=None,
        help="Exclusive end index into the representative list.",
    )
    parser.add_argument("--steps", type=int, default=1500)
    parser.add_argument("--lr", type=float, default=3e-2)
    parser.add_argument("--restarts", type=int, default=8)
    parser.add_argument("--d-model", type=int, default=32)
    parser.add_argument("--d-head", type=int, default=32)
    parser.add_argument(
        "--device",
        choices=("auto", "cpu", "cuda", "mps"),
        default="auto",
        help="Torch device for the experimental attention search.",
    )
    parser.add_argument(
        "--no-stop-on-perfect-accuracy",
        action="store_true",
        help="Keep optimizing after perfect classification until the loss criterion is met.",
    )
    parser.add_argument(
        "--robust",
        action="store_true",
        help="Run a stronger second-pass search to reduce restart sensitivity.",
    )
    parser.add_argument(
        "--robust-steps-multiplier",
        type=int,
        default=4,
        help="Multiplier for the second-pass training steps.",
    )
    parser.add_argument(
        "--robust-restarts-multiplier",
        type=int,
        default=4,
        help="Multiplier for the second-pass restart count.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Optional JSON path for the result payload.",
    )
    parser.add_argument(
        "--checkpoint-every",
        type=int,
        default=None,
        help="If set with --output, rewrite the JSON file every N processed representatives.",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Print training progress for each restart.",
    )
    return parser


def main() -> None:
    args = build_parser().parse_args()
    training = TrainingConfig(
        steps=args.steps,
        learning_rate=args.lr,
        restarts=args.restarts,
        d_model=args.d_model,
        d_head=args.d_head,
        device=args.device,
        stop_on_perfect_accuracy=not args.no_stop_on_perfect_accuracy,
        verbose=args.verbose,
    )
    config = SearchConfig(
        max_heads=args.max_heads,
        training=training,
        robust_estimate=args.robust,
        robust_steps_multiplier=args.robust_steps_multiplier,
        robust_restarts_multiplier=args.robust_restarts_multiplier,
    )

    def maybe_checkpoint(payload: dict) -> None:
        if args.output is None or args.checkpoint_every is None:
            return
        if payload["processed_count"] % args.checkpoint_every != 0:
            return
        text = json.dumps(payload, indent=2)
        args.output.write_text(text + "\n", encoding="utf-8")

    payload = run_representative_search(
        args.n,
        config,
        limit=args.limit,
        start_index=args.start_index,
        end_index=args.end_index,
        progress_callback=maybe_checkpoint,
    )
    text = json.dumps(payload, indent=2)
    if args.output is not None:
        args.output.write_text(text + "\n", encoding="utf-8")
    print(text)


if __name__ == "__main__":
    main()
