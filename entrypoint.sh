#!/bin/bash
set -e  # Exit immediately if any command exits with a non-zero status

# Function to run database migrations
run_migrations() {
    echo "Applying database migrations..."
    python manage.py migrate
}

# Function to collect static files
collect_static() {
    echo "Collecting static files..."
    python manage.py collectstatic --noinput
}

# Function to start the Gunicorn server
start_server() {
    echo "Starting the Gunicorn server..."
    exec "$@"  # This will run the CMD defined in Dockerfile or docker-compose
}

# Main script execution
cd /app  # Navigate to the application directory

run_migrations
collect_static
start_server gunicorn --workers 3 --bind 0.0.0.0:8000 THE24_Website.wsgi:application

