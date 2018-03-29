#!/usr/bin/env bash

# dev only

source /scripts/setenv_django.sh
cd $PROJHOME
python manage.py runserver
