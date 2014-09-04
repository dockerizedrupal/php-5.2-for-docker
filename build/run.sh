#!/usr/bin/env bash

if [ -n "${1}" ]; then
  cd /src

  php "${@:2}"
else
  /usr/bin/supervisord
fi
