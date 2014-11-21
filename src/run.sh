#!/usr/bin/env bash

export FACTER_SSMTP_HOST="$(echo "${SSMTP_PORT}" | sed 's/tcp:\/\///')"
export FACTER_MYSQLD_HOST="$(echo "${MYSQLD_PORT}" | sed 's/tcp:\/\///')"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
