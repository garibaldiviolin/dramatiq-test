FROM python:3.12.0-slim as base

ARG APPLICATION_ENVIRONMENT

# Setup env
ENV APPLICATION_ENVIRONMENT=${APPLICATION_ENVIRONMENT}
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

FROM base AS python-deps

# Install poetry and compilation dependencies
RUN pip install --upgrade pip && pip install poetry
RUN apt-get update && apt-get install -y --no-install-recommends gcc

# Install python dependencies in /.venv
COPY ./pyproject.toml ./poetry.lock* ./
RUN echo "$APPLICATION_ENVIRONMENT"
RUN poetry config virtualenvs.create false \
    && poetry install $(test "$APPLICATION_ENVIRONMENT" == production && echo "--no-dev") \
    --no-interaction --no-ansi

FROM python-deps AS runtime

COPY src /home/src
WORKDIR /home/src/background_processes

# Run the application
CMD ["dramatiq", "worker"]
