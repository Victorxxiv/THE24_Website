# Use an official Python runtime as a base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=THE24_Website.settings


# Set the working directory inside the container and create necessary directories
RUN mkdir -p /app /app/staticfiles /app/media /app/logs
WORKDIR /app

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy only requirements first to utilize caching effectively
COPY requirements.txt /app/

# Install system dependencies and required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https ca-certificates libpq-dev gcc python3-dev build-essential curl \
    && pip install --no-cache-dir --default-timeout=1000 -r requirements.txt \
    && apt-get purge -y --auto-remove gcc python3-dev build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of your application
COPY . /app/

# Add a non-root user for security
RUN adduser --disabled-password --gecos '' myuser

# Set correct permissions for non-root user on necessary directories
RUN chown -R myuser:myuser /app \
    && chmod -R 755 /app/staticfiles /app/media /app/logs

# Collect static files for Django to serve them
RUN python manage.py collectstatic --noinput

# Switch to the non-root user
USER myuser

# Expose the port on which Django runs
EXPOSE 8000

# Healthcheck (optional)
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:8000/ || exit 1

# Command to run the application using gunicorn
# CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "THE24_Website.wsgi:application"]

# Use entrypoint.sh to run the application with dynamic worker calculation
ENTRYPOINT ["/app/entrypoint.sh"]

# Include Nginx configuration files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
