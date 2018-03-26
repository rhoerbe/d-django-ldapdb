#!/usr/bin/env bash

# dev only

source /scripts/setenv_django.sh
cd $HOME/django_ldap
python manage_dev.py runserver
