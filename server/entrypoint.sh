#!/bin/sh
set -e

echo " Running Django migrations..."
python manage.py makemigrations --noinput
python manage.py migrate --noinput

echo " Collecting static files..."
python manage.py collectstatic --noinput

echo " Checking for existing superuser..."
python manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
username = "${DJANGO_SUPERUSER_USERNAME}"
email = "${DJANGO_SUPERUSER_EMAIL}"
password = "${DJANGO_SUPERUSER_PASSWORD}"

if username and email and password:
    if not User.objects.filter(username=username).exists():
        User.objects.create_superuser(username, email, password)
        print(f" Superuser '{username}' created.")
    else:
        print(f" Superuser '{username}' already exists.")
else:
    print(" Missing superuser environment variables. Skipping creation.")
EOF

echo " Starting application..."
exec "$@"
