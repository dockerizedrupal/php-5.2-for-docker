#!/usr/bin/env bash

puppet apply --modulepath=/src/php/run/modules /src/php/run/run.pp

/usr/bin/supervisord
