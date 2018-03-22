# -*- coding: utf-8 -*-
# This software is distributed under the two-clause BSD license.
# Copyright (c) The django-ldapdb project


from django import forms
from django.contrib import admin
from django.contrib.admin.widgets import FilteredSelectMultiple

from examples.models import LdapUser


class LdapUserAdmin(admin.ModelAdmin):
    exclude = ['dn']
    list_display = ['first_name', 'last_name']
    search_fields = ['first_name', 'last_name', 'full_name']


admin.site.register(LdapUser, LdapUserAdmin)
