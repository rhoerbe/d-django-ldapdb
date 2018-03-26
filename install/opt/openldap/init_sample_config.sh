#!/bin/sh
# initialize slapd.conf
cp -n /opt/openldap/slapd.conf /etc/openldap
cp -n /opt/openldap/DB_CONFIG /var/db/openldap
if [ $(grep -q '^rootpw' /etc/openldap/slapd.conf) ]; then
    echo "rootpw directive already set in slapd.conf"
else
    slappasswd -s $ROOTPW > /tmp/rootpw
    printf "\nrootpw $(cat /tmp/rootpw)" >> /etc/openldap/slapd.conf
    rm -f /tmp/rootpw
    echo "rootpw directive added to slapd.conf"
fi

echo "next step to do: start slapd and load initial data"