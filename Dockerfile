FROM --platform=linux/amd64 python:3.10-slim as base

WORKDIR /app
COPY pyproject.toml poetry.lock README.md ./
COPY dscreator dscreator/
COPY tests tests/

FROM base as builder

RUN pip install poetry
RUN poetry config virtualenvs.create false

RUN poetry export --without-hashes --with dev -f requirements.txt -o requirements.txt
RUN poetry build 

FROM base as runtime

COPY --from=builder /app/dist/ /app/dist/
RUN pip install /app/dist/*.whl

FROM runtime as test

COPY --from=builder /app/requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
RUN pytest -m "not docker" .

FROM runtime as prod

ARG GIT_COMMIT_ID=unknown
LABEL git_commit_id=$GIT_COMMIT_ID
ENV GIT_COMMIT_ID=$GIT_COMMIT_ID

ENTRYPOINT ["dscreator"]