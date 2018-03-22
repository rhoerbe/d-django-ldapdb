# Deploy django-ldapdb on Centos7

This project is a starting point to deploy django-ldapdb.

  git clone git@github.com:rhoerbe/d-django-ldapdb.git
  cd d-django-ldapdb
  git submodule update --init
  cp conf.sh.default conf.sh
  ./dscripts/build.sh  # will run make test as proof that the installation is OK
  ./dscripts/run.sh -i bash #  here you go ..