#!/bin/sh

echo "Making migrations and migrating the database."
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

# Create superuser if it doesn't exist
echo "from django.contrib.auth import get_user_model; User = get_user_model(); \
if not User.objects.filter(username='root').exists(): \
    User.objects.create_superuser('root', 'admin@mail.com', 'root')" | python manage.py shell

exec "$@"
