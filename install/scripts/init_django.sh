#!/usr/bin/env bash

source /scripts/setenv_django.sh
cd $PROJHOME
python manage.py makemigrations
python manage.py migrate
cd $PROJHOME
python /scripts/createsuperuser_test.py

