#!/usr/bin/env bash

if [ -n "${1}" ]; then
  sudo docker run --rm -i -t -v $(pwd):/src simpledrupalcloud/php:5.2.17 "${@}"
else
  sudo docker run --name php --net host --volumes-from apache -d simpledrupalcloud/php:5.2.17
fi
