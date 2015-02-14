#!/usr/bin/env bash

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
