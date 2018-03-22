#!/usr/bin/env bash

/opt/openldap/init_sample_config.sh
/scripts/start_slapd.sh
/opt/openldap/init_sample_data_gvAt.sh
/opt/openldap/init_sample_data_gvAt.sh