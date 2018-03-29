# -*- coding: utf-8 -*-
# This software is distributed under the two-clause BSD license.
# Copyright (c) The django-ldapdb project

from __future__ import unicode_literals

import ldapdb.models
from ldapdb.models.fields import CharField, ImageField, IntegerField, ListField


class LdapUser(ldapdb.models.Model):
    # LDAP meta-data
    base_dn = "dc=at"
    object_classes = ['inetOrgPerson']

    first_name = CharField(db_column='givenName')
    last_name = CharField("surname", db_column='sn')
    full_name = CharField(db_column='cn')
    email = CharField(db_column='mail', primary_key=True)

    #ordering = ['last_name']


    def __str__(self):
        return self.full_name

    def __unicode__(self):
        return self.full_name


