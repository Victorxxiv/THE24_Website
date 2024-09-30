# Use an official Python runtime as a base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory inside the container
WORKDIR /app

# Copy requirements.txt into the container
COPY requirements.txt /app/

# Install system dependencies and required packages
RUN apt-get update && \
    apt-get install -y libpq-dev gcc && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    apt-get remove --purge -y gcc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the entire project to the working directory in the container
COPY . /app/

# Set environment variables for Django
ENV DJANGO_SETTINGS_MODULE=THE24_Website.settings

# Collect static files for Django to serve them
RUN python manage.py collectstatic --noinput

# Expose the port on which Django runs
EXPOSE 8000

# Add a non-root user
RUN adduser --disabled-password myuser
USER myuser

# Healthcheck (optional)
HEALTHCHECK CMD curl --fail http://localhost:8000/ || exit 1

# Command to run the application using gunicorn
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "THE24_Website.wsgi:application"]
