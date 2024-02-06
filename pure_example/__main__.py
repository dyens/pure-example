from pure_example.pure_example import PureExample


def main() -> int:
    """Run app."""
    print(PureExample().hello_world())  # noqa:T201
    return 0


raise SystemExit(main())
