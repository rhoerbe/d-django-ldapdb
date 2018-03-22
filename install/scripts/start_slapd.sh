#!/usr/bin/env bash

debuglevel=${DEBUGLEVEL:-conns,config,stats,shell,trace}
echo "starting slapd, DEBUGLEVEL=$debuglevel"

slapd -4 -h ldap://${SLAPDHOST:-localhost}:${SLAPDPORT:-8389}/ -d $debuglevel -f /etc/openldap/slapd.conf
