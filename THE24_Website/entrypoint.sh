#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

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
    exec "$@"  # This will replace the shell with the command passed as arguments
}

# Main script execution
cd /app  # Navigate to the application directory

run_migrations
collect_static
start_server gunicorn --workers 3 --bind 0.0.0.0:8000 THE24_Website.wsgi:application
