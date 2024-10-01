#!/bin/bash
# entrypoint.sh

# Navigate to the directory containing manage.py
cd /app  # According to Docker setup

# Run database migrations
echo "Running databse migrations..."
if python manage.py migrate; then
    echo "Migrations applied successfully"
else
    echo "Migration failed!" >&2
    exit 1  # Exit with an error status if migration fails
fi

# Start the Gunicorn server
echo "Starting the Gunicorn server..."
exec "$@"