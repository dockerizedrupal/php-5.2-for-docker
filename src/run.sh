#!/usr/bin/env bash

SMTP_PORT="$(echo "${SMTP_PORT}" | sed 's/tcp:\/\///')"

export FACTER_SMTP_HOST="$(echo "${SMTP_PORT}" | cut -d ":" -f1)"
export FACTER_SMTP_PORT="$(echo "${SMTP_PORT}" | cut -d ":" -f2)"

DB_HOST="$(echo "${DB_PORT}" | sed 's/tcp:\/\///')"

export FACTER_DB_HOST="$(echo "${DB_HOST}" | cut -d ":" -f1)"
export FACTER_DB_PORT="$(echo "${DB_HOST}" | cut -d ":" -f2)"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
