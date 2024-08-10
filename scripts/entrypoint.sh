#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Print each command to stdout before executing it.
set -x

# Wait for the database to be ready.
# echo "Waiting for database..."
# while ! nc -z db 5432; do
#   sleep 1
# done

# Apply database migrations.
# echo "Applying database migrations..."
# python manage.py migrate

# Collect static files (if using Django).
# echo "Collecting static files..."
# python manage.py collectstatic --noinput

cd django
pwd
ls
python manage.py migrate
python manage.py runserver 0.0.0.0:8000