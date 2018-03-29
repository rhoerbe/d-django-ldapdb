#!/usr/bin/env bash

# dev only

source /scripts/setenv_django.sh
cd $PROJHOME
python manage.py runserver 0.0.0.0:8000
