#!/usr/bin/env bash

SMTP_PORT="$(echo "${SMTP_PORT}" | sed 's/tcp:\/\///')"

export FACTER_SMTP_HOST="$(echo "${SMTP_PORT}" | cut -d ":" -f1)"
export FACTER_SMTP_PORT="$(echo "${SMTP_PORT}" | cut -d ":" -f2)"

MYSQLD_HOST="$(echo "${MYSQLD_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MYSQLD_HOST="$(echo "${MYSQLD_HOST}" | cut -d ":" -f1)"
export FACTER_MYSQLD_PORT="$(echo "${MYSQLD_HOST}" | cut -d ":" -f2)"

MEMCACHED_HOST="$(echo "${MEMCACHED_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MEMCACHED_HOST="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f1)"
export FACTER_MEMCACHED_PORT="$(echo "${MEMCACHED_HOST}" | cut -d ":" -f2)"

REDIS_HOST="$(echo "${REDIS_PORT}" | sed 's/tcp:\/\///')"

export FACTER_REDIS_HOST="$(echo "${REDIS_HOST}" | cut -d ":" -f1)"
export FACTER_REDIS_PORT="$(echo "${REDIS_HOST}" | cut -d ":" -f2)"

if [ -z "${PHP_EXTENSION_OPCACHE_ENABLE}" ]; then
  PHP_EXTENSION_OPCACHE_ENABLE=1
fi

export FACTER_PHP_EXTENSION_OPCACHE_ENABLE="${PHP_EXTENSION_OPCACHE_ENABLE}"

if [ -z "${PHP_EXTENSION_XDEBUG_ENABLE}" ]; then
  PHP_EXTENSION_XDEBUG_ENABLE=1
fi

export FACTER_PHP_EXTENSION_XDEBUG_ENABLE="${PHP_EXTENSION_XDEBUG_ENABLE}"

if [ -z "${PHP_EXTENSION_MEMCACHED_ENABLE}" ]; then
  PHP_EXTENSION_MEMCACHED_ENABLE=1
fi

export FACTER_PHP_EXTENSION_MEMCACHED_ENABLE="${PHP_EXTENSION_MEMCACHED_ENABLE}"

if [ -z "${PHP_EXTENSION_REDIS_ENABLE}" ]; then
  PHP_EXTENSION_REDIS_ENABLE=1
fi

export FACTER_PHP_EXTENSION_REDIS_ENABLE="${PHP_EXTENSION_REDIS_ENABLE}"

if [ -z "${PHP_EXTENSION_APCU_ENABLE}" ]; then
  PHP_EXTENSION_APCU_ENABLE=1
fi

export FACTER_PHP_EXTENSION_APCU_ENABLE="${PHP_EXTENSION_APCU_ENABLE}"

if [ -z "${PHP_EXTENSION_APD_ENABLE}" ]; then
  PHP_EXTENSION_APD_ENABLE=1
fi

export FACTER_PHP_EXTENSION_APD_ENABLE="${PHP_EXTENSION_APD_ENABLE}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
