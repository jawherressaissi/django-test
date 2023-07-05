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

# Set Celery environment variables
ENV CELERY_BROKER_URL redis://redis:6379/0
ENV CELERY_RESULT_BACKEND redis://redis:6379/0

# Run Django migrations
#RUN python manage.py migrate
RUN celery -A testapp worker -l info --without-gossip --pool=solo

# Start the Django development server and Celery worker
#CMD ["bash", "-c", "python manage.py runserver 0.0.0.0:8000"]
