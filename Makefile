PROJECT_NAME = pure_example
REQUIREMENTS_TXT = requirements.txt
REQUIREMENTS_DEV_TXT = requirements-dev.txt
DOCKER_IMAGE := pure-example:latest
DOCKER_IMAGE_DEV := pure-example-dev:latest


.PHONY: pip-compile
pip-compile:
	pip-compile --upgrade --strip-extras --generate-hashes -o $(REQUIREMENTS_TXT)
	pip-compile --upgrade --strip-extras --extra=dev --generate-hashes -o $(REQUIREMENTS_DEV_TXT)

.PHONY: pip-sync
pip-sync:
	pip-sync $(REQUIREMENTS_TXT) $(REQUIREMENTS_DEV_TXT)


.PHONY: run
run:
	python -m $(PROJECT_NAME)

.PHONY: prod-run
prod-run:
	ENV_FOR_DYNACONF=production python -m $(PROJECT_NAME)

.PHONY: docker-build
docker-build:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMAGE) --target app .

.PHONY: docker-build-dev
docker-build-dev:
	DOCKER_BUILDKIT=1 docker build -t $(DOCKER_IMAGE_DEV) --target dev .

.PHONY: test
test:
	pytest

.PHONY: test-cov
test-cov:
	coverage run -m pytest
	coverage report -m

.PHONY: cov-html
cov-html:
	coverage html

.PHONY: ruff
ruff:
	ruff check

.PHONY: mypy
mypy:
	mypy $(PROJECT_NAME)

.PHONY: lint
lint: mypy ruff


.PHONY: build
build:
	python -m build --sdist

release: dist/*
	twine check --strict $^
	twine upload --disable-progress-bar $^
