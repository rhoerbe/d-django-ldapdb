#!/usr/bin/env bash


main() {
    init_sample_config
    /scripts/start_slapd.sh &
    wait_for_slapd_started
    init_sample_data
    terminate_slapd
}


init_sample_config() {
    echo "initialize slapd.conf"
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
}


wait_for_slapd_started() {
    while ! netstat -tnap | grep "127.0.0.1:${SLAPDPORT:-8389}"; do
        sleep 2;
    done
}


init_sample_data() {
    echo "loading /etc/openldap with sample data "

    rootdn=$(grep ^rootdn /etc/openldap/slapd.conf | awk {'print $2'} | tr -d '"')

    ldapadd -h localhost -p ${SLAPDPORT:-8389} \
        -x -D $rootdn -w $ROOTPW \
        -c -f /opt/openldap/gvAt_init.ldif

    ldappasswd -h localhost -p ${SLAPDPORT:-8389} \
        -x -D $rootdn -w $ROOTPW \
        -s 'test' 'uid=test@bmspot.gv.at,ou=people,cn=Testorg,dc=gv,dc=at'
}


terminate_slapd() {
    kill $(cat /var/run/openldap/slapd.pid)
    while netstat -tnap | grep "127.0.0.1:${SLAPDPORT:-8389}"; do
        sleep 2;
    done
}


main $@