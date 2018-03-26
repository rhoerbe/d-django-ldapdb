#!/usr/bin/env bash

# dev only

source /scripts/setenv_django.sh
cd $HOME/django-ldapdb
python manage_dev.py runserver
