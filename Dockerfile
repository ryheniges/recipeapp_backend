# https://faun.pub/the-near-perfect-dockerfile-for-django-applications-8bc352a1e871
FROM python:3.12.4-slim

# Realtime stdout/stderr
ENV PYTHONUNBUFFERED 1

ENV APP_USER=django_user
ENV APP_USER_ID=1111

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment
RUN python -m venv /opt/venv

# Upgrade pip and setuptools
RUN /opt/venv/bin/pip install --upgrade pip setuptools

COPY requirements.txt /tmp/requirements.txt

RUN /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt 

RUN useradd -u ${APP_USER_ID} -m ${APP_USER} \
    && install -d -m 0755 -o $APP_USER -g $APP_USER /django/static

ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /django
COPY --chown=$APP_USER:$APP_USER . .
RUN ls
RUN chmod +x scripts/*.sh
# RUN chmod -R 755 /django/django/recipe_base/migrations
USER $APP_USER:$APP_USER

ENTRYPOINT [ "scripts/entrypoint.sh" ]