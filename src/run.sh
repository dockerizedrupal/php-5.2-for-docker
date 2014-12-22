#!/usr/bin/env bash

SMTP_PORT="$(echo "${SMTP_PORT}" | sed 's/tcp:\/\///')"

export FACTER_SMTP_HOST="$(echo "${SMTP_PORT}" | cut -d ":" -f1)"
export FACTER_SMTP_PORT="$(echo "${SMTP_PORT}" | cut -d ":" -f2)"

DB_HOST="$(echo "${DB_PORT}" | sed 's/tcp:\/\///')"

export FACTER_DB_HOST="$(echo "${DB_HOST}" | cut -d ":" -f1)"
export FACTER_DB_PORT="$(echo "${DB_HOST}" | cut -d ":" -f2)"

MEMCACHED_HOST="$(echo "${MEMCACHED_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MEMCACHED_HOST="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f1)"
export FACTER_MEMCACHED_PORT="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f2)"

REDIS_HOST="$(echo "${REDIS_PORT}" | sed 's/tcp:\/\///')"

export FACTER_REDIS_HOST="$(echo "${REDIS_HOST}" | cut -d ":" -f1)"
export FACTER_REDIS_PORT="$(echo "${REDIS_HOST}" | cut -d ":" -f2)"

if [ -z "${OPCACHE_ENABLE}" ]; then
  OPCACHE_ENABLE=1
fi

export FACTER_OPCACHE_ENABLE="${OPCACHE_ENABLE}"

if [ -z "${XDEBUG_ENABLE}" ]; then
  XDEBUG_ENABLE=1
fi

export FACTER_XDEBUG_ENABLE="${XDEBUG_ENABLE}"

if [ -z "${MEMCACHED_ENABLE}" ]; then
  MEMCACHED_ENABLE=1
fi

export FACTER_MEMCACHED_ENABLE="${MEMCACHED_ENABLE}"

if [ -z "${REDIS_ENABLE}" ]; then
  REDIS_ENABLE=1
fi

export FACTER_REDIS_ENABLE="${REDIS_ENABLE}"

if [ -z "${BLACKFIRE_ENABLE}" ]; then
  BLACKFIRE_ENABLE=1
fi

export FACTER_BLACKFIRE_ENABLE="${BLACKFIRE_ENABLE}"

if [ -z "${APCU_ENABLE}" ]; then
  APCU_ENABLE=1
fi

export FACTER_APCU_ENABLE="${APCU_ENABLE}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
