FROM centos:centos7
MAINTAINER Rainer Hörbe <r2h2@hoerbe.at>

# Django-ldapdb with python3.4

RUN yum -y update \
 && yum -y install epel-release \
 && yum -y install git python34-devel openldap-devel \
 && curl https://bootstrap.pypa.io/get-pip.py | python3.4


ARG USERNAME=default
ARG CONTAINERUID=1000
ARG CONTAINERGID=1000
RUN groupadd --non-unique -g $CONTAINERGID $USERNAME \
 && useradd  --non-unique --gid $CONTAINERGID --uid $CONTAINERUID $USERNAME

USER $USERNAME

RUN cd \
 && git clone https://github.com/django-ldapdb/django-ldapdb \
 && cd django-ldapdb \
 && mkdir virtenv \
 && python3.4 -m venv virtenv \
 && source virtenv/bin/activate \
 && pip install -r requirements_dev.txt \
 && pip freeze

RUN make test

