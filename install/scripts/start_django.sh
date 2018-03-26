#!/usr/bin/env bash

# dev only

cd
source virtenv/bin/activate
cd django-ldapdb
python manage_dev.py runserver
