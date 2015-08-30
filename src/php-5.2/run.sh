#!/usr/bin/env bash

puppet apply --modulepath=/src/php-5.2/run/modules /src/php-5.2/run/run.pp

supervisord -c /etc/supervisor/supervisord.conf
