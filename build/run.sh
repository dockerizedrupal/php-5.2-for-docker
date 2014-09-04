#!/usr/bin/env bash

if [ "${#}" -gt 0 ]; then
  cd /src

  php "${@}"
else
  /usr/bin/supervisord
fi
