#!/usr/bin/env bash

dnsLookup() {
  echo "$(host "${1}" | awk '/has address/ { print $4 }')"
}

if [ -z "${SSMTP_PORT_25_TCP}" ] && [ -n "${SSMTP_PORT_25_TCP_ADDR}" ] && [ -n "${SSMTP_PORT_25_TCP_PORT}" ]; then
  IP="$(dnsLookup "${SSMTP_PORT_25_TCP_ADDR}")"

  if [ ! -z "${IP}" ]; then
    SSMTP_PORT_25_TCP_ADDR="${IP}"
  fi

  SSMTP_PORT_25_TCP="tcp://${SSMTP_PORT_25_TCP_ADDR}:${SSMTP_PORT_25_TCP_PORT}"
fi

export FACTER_SSMTP_PORT_25_TCP="$(echo "${SSMTP_PORT_25_TCP}" | sed 's/tcp:\/\///')"

if [ -z "${MYSQL_PORT_3306_TCP}" ] && [ -n "${MYSQL_PORT_3306_TCP_ADDR}" ] && [ -n "${MYSQL_PORT_3306_TCP_PORT}" ]; then
  IP="$(dnsLookup "${MYSQL_PORT_3306_TCP_ADDR}")"

  if [ ! -z "${IP}" ]; then
    MYSQL_PORT_3306_TCP_ADDR="${IP}"
  fi

  MYSQL_PORT_3306_TCP="tcp://${MYSQL_PORT_3306_TCP_ADDR}:${MYSQL_PORT_3306_TCP_PORT}"
fi

export FACTER_MYSQL_PORT_3306_TCP="$(echo "${MYSQL_PORT_3306_TCP}" | sed 's/tcp:\/\///')"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
