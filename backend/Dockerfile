# stage one 

FROM python:3.13-slim AS builder

WORKDIR  /app


COPY requirements.txt tmp/


RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r tmp/requirements.txt && \
    apt-get purge -y --auto-remove build-essential && \
    rm -rf var/lib/apt/lists/* tmp /root/.cache

# stage two 

FROM python:3.13-slim AS runner

COPY --from=builder /usr/local/lib/python3.13 /usr/local/lib/python3.13
COPY --from=builder /usr/local/bin /usr/local/bin

COPY . .

EXPOSE 6000

CMD [ "uvicorn","app.main:app","--host","0.0.0.0","--port","8001" ]









