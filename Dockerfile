# Base image
FROM python:3.9.7

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the Django project files
COPY . .

# Run Django migrations
RUN python manage.py migrate

# Start the Django development server and Celery worker
CMD ["bash", "-c", "python manage.py runserver 0.0.0.0:8000"]
