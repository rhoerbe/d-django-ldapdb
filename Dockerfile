FROM centos:centos7
MAINTAINER Rainer Hörbe <r2h2@hoerbe.at>

# Django-ldapdb with python3.4

RUN yum -y update \
 && yum -y install curl ip lsof net-tools wget which \
 && yum -y install epel-release git gcc make

# install PY 3.4 from EPEL
#RUN yum -y install python34-devel openldap-devel \
# && curl https://bootstrap.pypa.io/get-pip.py | python3.4

# install py3.5 from IUS
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
 && yum -y install python35u python35u-setuptools python35u-devel python35u-pip \
 && yum -y install openldap-servers openldap-clients openldap-devel \
 && yum clean all


ARG USERNAME=default
ARG CONTAINERUID=1000
ARG CONTAINERGID=1000
RUN groupadd --non-unique -g $CONTAINERGID $USERNAME \
 && useradd  --non-unique --gid $CONTAINERGID --uid $CONTAINERUID $USERNAME

COPY install/opt /opt
COPY install/scripts /scripts
RUN chmod +x /scripts/* \
 && mkdir -p /var/db/openldap /var/log/openldap /var/run/openldap \
 && chown $USERNAME /etc/openldap /opt/django_ldap /var/db/openldap /var/log/openldap /var/run/openldap

USER $USERNAME

# setup virtual env with previously installed python
# install pyroma>=2.4.dev0 because of https://github.com/regebro/pyroma/issues/12
# install django-ldapdb
RUN cd \
 && mkdir virtenv \
 && python3.5 -m venv virtenv \
 && source virtenv/bin/activate \
 && cd \
 && git clone https://github.com/regebro/pyroma.git \
 && cd pyroma \
 && python setup.py install \
 && cd \
 && rm -rf pyroma \
 && cd \
 && git clone https://github.com/django-ldapdb/django-ldapdb \
 && cd django-ldapdb \
 && pip install -r requirements_dev.txt \
 && pip freeze \
 && make test


EXPOSE 8000