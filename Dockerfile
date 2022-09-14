FROM python:3.8-slim as base
FROM base as builder

RUN pip install poetry

WORKDIR /app
COPY pyproject.toml poetry.lock README.md ./
COPY dataexport dataexport/
COPY tests tests/

RUN poetry config virtualenvs.create false && \
    poetry build --format wheel && \
    pip install --user --force-reinstall --no-warn-script-location dist/*

FROM builder as test

RUN poetry export --without-hashes --dev | pip install -r /dev/stdin
RUN pytest .

FROM base as prod

COPY --from=builder /root/.local /usr/local

ARG GIT_COMMIT_ID=unknown
LABEL git_commit_id=$GIT_COMMIT_ID
ENV GIT_COMMIT_ID=$GIT_COMMIT_ID

ENTRYPOINT ["dataexport"]