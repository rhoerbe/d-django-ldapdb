#!/usr/bin/env bash

debuglevel=${DEBUGLEVEL:-conns,config,stats,shell}   # add trace to be more verbose
echo "starting slapd, DEBUGLEVEL=$debuglevel"

slapd -h ldap://${SLAPDHOST:-localhost}:${SLAPDPORT:-8389}/ \
      -d $debuglevel \
      -f /etc/openldap/slapd.conf \
      >> /var/log/openldap/slapd.log 2>&1 &

echo 'waiting for slapd to start'
while ! netstat -tnap | grep "127.0.0.1:${SLAPDPORT:-8389}"; do
    sleep 2;
done

