#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/php/build.sh && /src/php/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/php/variables.sh && /src/php/run.sh"
    ;;
esac
