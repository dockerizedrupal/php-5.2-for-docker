#!/usr/bin/env bash

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

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

if [ -z "${DRUPAL_VERSION}" ]; then
  DRUPAL_VERSION="6"
fi

export FACTER_DRUPAL_VERSION="${DRUPAL_VERSION}"

if [ -z "${PHP_EXTENSION_OPCACHE_ENABLE}" ]; then
  PHP_EXTENSION_OPCACHE_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_OPCACHE_ENABLE="${PHP_EXTENSION_OPCACHE_ENABLE}"

if [ -z "${PHP_EXTENSION_XDEBUG_ENABLE}" ]; then
  PHP_EXTENSION_XDEBUG_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_XDEBUG_ENABLE="${PHP_EXTENSION_XDEBUG_ENABLE}"

if [ -z "${PHP_EXTENSION_MEMCACHED_ENABLE}" ]; then
  PHP_EXTENSION_MEMCACHED_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_MEMCACHED_ENABLE="${PHP_EXTENSION_MEMCACHED_ENABLE}"

if [ -z "${PHP_EXTENSION_REDIS_ENABLE}" ]; then
  PHP_EXTENSION_REDIS_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_REDIS_ENABLE="${PHP_EXTENSION_REDIS_ENABLE}"

if [ -z "${PHP_EXTENSION_APCU_ENABLE}" ]; then
  PHP_EXTENSION_APCU_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_APCU_ENABLE="${PHP_EXTENSION_APCU_ENABLE}"

if [ -z "${PHP_EXTENSION_APD_ENABLE}" ]; then
  PHP_EXTENSION_APD_ENABLE="yes"
fi

export FACTER_PHP_EXTENSION_APD_ENABLE="${PHP_EXTENSION_APD_ENABLE}"

for VARIABLE in $(env); do
  if [[ "${VARIABLE}" == FREETDS_*_HOST=* ]]; then
    i="$(echo ${VARIABLE} | awk -F '_' '{ print $2 }')"

    FREETDS_HOST="FREETDS_${i}_HOST"

    if [ -z "${!FREETDS_HOST}" ]; then
      continue
    fi

    export "FACTER_${FREETDS_HOST}=${!FREETDS_HOST}"

    FREETDS_PORT="FREETDS_${i}_PORT"

    if [ -z "${!FREETDS_PORT}" ]; then
      declare "${FREETDS_PORT}=1433"
    fi

    export "FACTER_${FREETDS_PORT}=${!FREETDS_PORT}"

    FREETDS_TDS_VERSION="FREETDS_${i}_TDS_VERSION"

    if [ -z "${!FREETDS_TDS_VERSION}" ]; then
      declare "${FREETDS_TDS_VERSION}=8.0"
    fi

    export "FACTER_${FREETDS_TDS_VERSION}=${!FREETDS_TDS_VERSION}"

    FREETDS_SERVER_NAME="FREETDS_${i}_SERVER_NAME"

    if [ -z "${!FREETDS_SERVER_NAME}" ]; then
      declare "${FREETDS_SERVER_NAME}=server-${i}"
    fi

    export "FACTER_${FREETDS_SERVER_NAME}=${!FREETDS_SERVER_NAME}"
  fi
done
