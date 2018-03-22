#!/bin/sh

echo "loading /etc/openldap with sample data "

rootdn=$(grep ^rootdn /etc/openldap/slapd.conf | awk {'print $2'} | tr -d '"')

ldapadd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -f /opt/openldap/gvAt_init.ldif

ldappasswd -h localhost -p $SLAPDPORT \
    -x -D $rootdn -w $ROOTPW \
    -s 'test' 'uid=test@bmspot.gv.at,ou=people,cn=Testorg,dc=gv,dc=at'

