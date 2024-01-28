import pytest

from pure_example.pure_example import PureExample


class TestPureExample:
    @pytest.fixture(scope="class")
    def pure_example(self) -> PureExample:
        return PureExample()

    def test_hello_world(self, pure_example) -> None:
        assert pure_example.hello_world() == "Hello world"
