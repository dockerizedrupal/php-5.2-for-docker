#!/usr/bin/env bash

puppet apply --modulepath=/src/php/run/modules /src/php/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf
