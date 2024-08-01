# https://faun.pub/the-near-perfect-dockerfile-for-django-applications-8bc352a1e871
FROM python:3.12.4-slim

# Realtime stdout/stderr
ENV PYTHONUNBUFFERED 1

ENV APP_USER = django_user

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential libpq-dev \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt \
    && useradd -U $APP_USER \
    && install -d -m 0755 -o $APP_USER -g $APP_USER /app/static

WORKDIR /app
USER $APP_USER:$APP_USER
COPY --chown=$APP_USER:$APP_USER . .
RUN chmod +x docker/*.sh

ENTRYPOINT [ "docker/entrypoint.sh" ]
CMD [ "docker/start.sh", "server" ]