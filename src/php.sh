#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/build.sh && /src/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/variables.sh && /src/run.sh"
    ;;
esac
