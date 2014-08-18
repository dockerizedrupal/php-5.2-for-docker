#!/usr/bin/env bash

puppet apply /opt/build/etc/puppet/manifests/run.pp

apache2ctl -D FOREGROUND