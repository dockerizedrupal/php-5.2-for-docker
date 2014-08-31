#!/usr/bin/env bash

case "${1}" in
  php52)
    cd /src

    php-5.2.17 "${@:2}"
    ;;
  php53)
    cd /src

    php-5.3.28 "${@:2}"
    ;;
  php54)
    cd /src

    php-5.4.31 "${@:2}"
    ;;
  php55)
    cd /src

    php-5.5.15 "${@:2}"
    ;;
  *)
    /usr/bin/supervisord
  ;;
esac
