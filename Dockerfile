FROM python:3.12.1-slim-bookworm AS base
# This flag is important to output python logs correctly in docker!
ENV PYTHONUNBUFFERED 1
# Flag to optimize container size a bit by removing runtime python cache
ENV PYTHONDONTWRITEBYTECODE 1
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

FROM base AS app
COPY ./pure_example /app/pure_example
CMD ["python", "-m", "pure_example"]

FROM app AS dev
COPY ./requirements-dev.txt /app/requirements-dev.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements-dev.txt
