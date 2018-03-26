#!/usr/bin/env bash

# dev only

source /scripts/setenv_django.sh
cd $PROJHOME
python manage_dev.py runserver
