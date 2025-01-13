FROM python:3.11-slim AS base

RUN pip install poetry
RUN poetry config virtualenvs.create false

WORKDIR /app
COPY pyproject.toml poetry.lock README.md ./
COPY dscreator dscreator/
COPY tests tests/

FROM base as builder

RUN poetry install --without dev,plots
RUN poetry build 

FROM base as runtime

COPY --from=builder /app/dist/ /app/dist/
RUN pip install /app/dist/*.whl

FROM runtime as test

RUN poetry install --with dev
RUN pytest -m "not docker" .

FROM runtime as prod

ARG GIT_COMMIT_ID=unknown
LABEL git_commit_id=$GIT_COMMIT_ID
ENV GIT_COMMIT_ID=$GIT_COMMIT_ID

ENTRYPOINT ["dscreator"]
