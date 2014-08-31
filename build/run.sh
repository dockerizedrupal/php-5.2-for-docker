#!/usr/bin/env bash

case "${1}" in
  php52)
    cd /src

    php-5.2.17 "${@:1}"
    ;;
  php53)
    cd /src

    php-5.3.28 "${@:1}"
    ;;
  php54)
    cd /src

    php-5.4.31 "${@:1}"
    ;;
  php55)
    cd /src

    php-5.5.15 "${@:1}"
    ;;
  *)
    /usr/bin/supervisord
  ;;
esac
