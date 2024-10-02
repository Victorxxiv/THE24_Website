# Use an official Python runtime as a base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=THE24_Website.settings

# Set working directory inside the container
WORKDIR /app

# Copy only requirements first to utilize caching effectively
COPY requirements.txt /app/

# Install system dependencies and required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libpq-dev \
        gcc \
        python3-dev \
        build-essential && \
    pip install --upgrade pip && \
    pip install --no-cache-dir --default-timeout=1000 -r requirements.txt && \
    apt-get remove --purge -y gcc python3-dev build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of your application
COPY . /app/

# Collect static files for Django to serve them
RUN python manage.py collectstatic --noinput

# Add a non-root user for security
RUN adduser --disabled-password --gecos '' myuser
USER myuser

# Expose the port on which Django runs
EXPOSE 8000

# Healthcheck (optional)
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:8000/ || exit 1

# Command to run the application using gunicorn
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "THE24_Website.wsgi:application"]
