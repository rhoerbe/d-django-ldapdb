#!/usr/bin/env bash

source /scripts/setenv_django.sh
cd $HOME/django_ldap
python manage_dev.py makemigrations
python manage_dev.py migrate
python /scripts/createsuperuser_test.py

