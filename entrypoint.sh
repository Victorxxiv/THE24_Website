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

# Function to calculate the number of Gunicorn workers based on available CPU cores
calculate_workers() {
    # Get the number of CPU cores available in the container
    CORES=$(getconf _NPROCESSORS_ONLN)
    # Use the recommended formula for Gunicorn workers: (2 x cores) + 1
    WORKERS=$((2 * CORES + 1))
    echo "Calculated $WORKERS Gunicorn workers based on $CORES CPU cores."
}

# Function to start the Gunicorn server
start_server() {
    echo "Starting the Gunicorn server with $WORKERS workers..."
    exec gunicorn --workers $WORKERS --bind 0.0.0.0:8000 THE24_Website.wsgi:application
}

# Main script execution
cd /app  # Navigate to the application directory

run_migrations
collect_static
calculate_workers
start_server
