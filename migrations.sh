#!/bin/sh

echo 'MIGRATIONS | Beginning script...'

# Default flag value
MIGRATE=false
MAKEMIGRATION=false

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -m|--migrate)
            MIGRATE=true
            ;;
        -mm|--make-migrations)
            MAKEMIGRATION=true
            ;;
        \*)
            echo "Invalid option: $1" >&2
            exit 1
            ;;
    esac
    shift
done

# Ensure app and db are started/healthchecks, wait until ready
docker start recipe_app
docker start recipe_db  

docker exec -it --user root recipe_app chown -R django_user:django_user /django/django/recipe_base/migrations

if [ "$MAKEMIGRATION" = true ]; then
# Run makemigrations command
    echo 'MIGRATIONS | Making migrations'
    docker exec -it --user django_user:django_user recipe_app python django/manage.py makemigrations
fi

if [ "$MIGRATE" = true ]; then
    echo 'MIGRATIONS | Migrating'   
    docker exec -it --user django_user:django_user recipe_app python django/manage.py migrate
fi

echo 'MIGRATIONS | Script complete!'