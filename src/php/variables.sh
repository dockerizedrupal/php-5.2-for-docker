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

if [ -z "${REALPATH_CACHE_SIZE}" ]; then
  REALPATH_CACHE_SIZE="256k"
fi

export FACTER_REALPATH_CACHE_SIZE="${REALPATH_CACHE_SIZE}"

if [ -z "${REALPATH_CACHE_TTL}" ]; then
  REALPATH_CACHE_TTL="3600"
fi

export FACTER_REALPATH_CACHE_TTL="${REALPATH_CACHE_TTL}"

if [ -z "${POST_MAX_SIZE}" ]; then
  POST_MAX_SIZE="512M"
fi

export FACTER_POST_MAX_SIZE="${POST_MAX_SIZE}"

if [ -z "${TIMEZONE}" ]; then
  TIMEZONE="UTC"
fi

export FACTER_TIMEZONE="${TIMEZONE}"

if [ -z "${UPLOAD_MAX_FILESIZE}" ]; then
  UPLOAD_MAX_FILESIZE="512M"
fi

export FACTER_UPLOAD_MAX_FILESIZE="${UPLOAD_MAX_FILESIZE}"

if [ -z "${SHORT_OPEN_TAG}" ]; then
  SHORT_OPEN_TAG="On"
fi

export FACTER_SHORT_OPEN_TAG="${SHORT_OPEN_TAG}"

if [ -z "${MAX_EXECUTION_TIME}" ]; then
  MAX_EXECUTION_TIME="300"
fi

export FACTER_MAX_EXECUTION_TIME="${MAX_EXECUTION_TIME}"

if [ -z "${MAX_INPUT_VARS}" ]; then
  MAX_INPUT_VARS="4096"
fi

export FACTER_MAX_INPUT_VARS="${MAX_INPUT_VARS}"

if [ -z "${MEMORY_LIMIT}" ]; then
  MEMORY_LIMIT="512M"
fi

export FACTER_MEMORY_LIMIT="${MEMORY_LIMIT}"

if [ -z "${DISPLAY_ERRORS}" ]; then
  DISPLAY_ERRORS="On"
fi

export FACTER_DISPLAY_ERRORS="${DISPLAY_ERRORS}"

if [ -z "${DISPLAY_STARTUP_ERRORS}" ]; then
  DISPLAY_STARTUP_ERRORS="On"
fi

export FACTER_DISPLAY_STARTUP_ERRORS="${DISPLAY_STARTUP_ERRORS}"

if [ -z "${ERROR_REPORTING}" ]; then
  ERROR_REPORTING="E_ALL"
fi

export FACTER_ERROR_REPORTING="${ERROR_REPORTING}"

if [ -z "${OPCACHE}" ]; then
  OPCACHE="On"
fi

export FACTER_OPCACHE="${OPCACHE}"

if [ -z "${OPCACHE_MEMORY_CONSUMPTION}" ]; then
  OPCACHE_MEMORY_CONSUMPTION="2048"
fi

export FACTER_OPCACHE_MEMORY_CONSUMPTION="${OPCACHE_MEMORY_CONSUMPTION}"

if [ -z "${XDEBUG}" ]; then
  XDEBUG="On"
fi

export FACTER_XDEBUG="${XDEBUG}"

if [ -z "${XDEBUG_REMOTE_PORT}" ]; then
  XDEBUG_REMOTE_PORT="9000"
fi

export FACTER_XDEBUG_REMOTE_PORT="${XDEBUG_REMOTE_PORT}"

if [ -z "${XDEBUG_REMOTE_HOST}" ]; then
  XDEBUG_REMOTE_HOST="127.0.0.1"
fi

export FACTER_XDEBUG_REMOTE_HOST="${XDEBUG_REMOTE_HOST}"

if [ -z "${XDEBUG_REMOTE_CONNECT_BACK}" ]; then
  XDEBUG_REMOTE_CONNECT_BACK="On"
fi

export FACTER_XDEBUG_REMOTE_CONNECT_BACK="${XDEBUG_REMOTE_CONNECT_BACK}"

if [ -z "${XDEBUG_IDEKEY}" ]; then
  XDEBUG_IDEKEY="PHPSTORM"
fi

export FACTER_XDEBUG_IDEKEY="${XDEBUG_IDEKEY}"

if [ -z "${MEMCACHED}" ]; then
  MEMCACHED="On"
fi

export FACTER_MEMCACHED="${MEMCACHED}"

if [ -z "${REDIS}" ]; then
  REDIS="On"
fi

export FACTER_REDIS="${REDIS}"

if [ -z "${APCU}" ]; then
  APCU="On"
fi

export FACTER_APCU="${APCU}"

if [ -z "${APD}" ]; then
  APD="On"
fi

export FACTER_APD="${APD}"

for VARIABLE in $(env); do
  if [[ "${VARIABLE}" =~ ^FREETDS_[[:digit:]]_HOST=.*$ ]]; then
    i="$(echo ${VARIABLE} | awk -F '_' '{ print $2 }')"

    FREETDS_HOST="FREETDS_${i}_HOST"
    FREETDS_PORT="FREETDS_${i}_PORT"
    FREETDS_TDS_VERSION="FREETDS_${i}_TDS_VERSION"
    FREETDS_SERVER_NAME="FREETDS_${i}_SERVER_NAME"

    if [ -z "${!FREETDS_HOST}" ]; then
      continue
    fi

    if [ -z "${!FREETDS_PORT}" ]; then
      declare "${FREETDS_PORT}=1433"
    fi

    if [ -z "${!FREETDS_TDS_VERSION}" ]; then
      declare "${FREETDS_TDS_VERSION}=8.0"
    fi

    if [ -z "${!FREETDS_SERVER_NAME}" ]; then
      declare "${FREETDS_SERVER_NAME}=server-${i}"
    fi

    export "FACTER_${FREETDS_HOST}=${!FREETDS_HOST}"
    export "FACTER_${FREETDS_PORT}=${!FREETDS_PORT}"
    export "FACTER_${FREETDS_TDS_VERSION}=${!FREETDS_TDS_VERSION}"
    export "FACTER_${FREETDS_SERVER_NAME}=${!FREETDS_SERVER_NAME}"
  fi
done
