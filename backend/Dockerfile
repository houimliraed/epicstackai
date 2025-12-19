# Stage 1: Builder
FROM python:3.13-slim AS builder

WORKDIR /app
COPY requirements.txt tmp/

RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev && \
    python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip wheel && \
    /opt/venv/bin/pip install --no-cache-dir -r tmp/requirements.txt && \
    apt-get purge -y --auto-remove build-essential && \
    rm -rf /var/lib/apt/lists/* tmp /root/.cache

# Stage 2: Runner
FROM python:3.13-slim AS runner
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY . .
ENV PYTHONPATH=/app
EXPOSE 8001

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8001"]
