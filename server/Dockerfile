FROM python:3.12.0-slim-bookworm

ENV PYTHONBUFFERED 1
ENV PYTHONWRITEBYTECODE 1

ENV APP=/app

# Change the working directory
WORKDIR $APP

# Copy requirements.txt and install dependencies
COPY requirements.txt $APP/
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Copy the rest of the application files
COPY . $APP

# Make entrypoint.sh executable
RUN chmod +x /app/entrypoint.sh

# Expose port 8000 for the Django app
EXPOSE 8000

# Use entrypoint.sh to handle migrations and static files, then start Gunicorn
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "djangoproj.wsgi"]
