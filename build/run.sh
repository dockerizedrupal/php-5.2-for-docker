#!/usr/bin/env bash

case "${1}" in
  php-5.2.17)
    cd /src

    php-5.2.17 "${@:2}"
    ;;
  php-5.3.28)
    cd /src

    php-5.3.28 "${@:2}"
    ;;
  php-5.4.31)
    cd /src

    php-5.4.31 "${@:2}"
    ;;
  php-5.5.15)
    cd /src

    php-5.5.15 "${@:2}"
    ;;
  *)
    /usr/bin/supervisord
    ;;
esac
