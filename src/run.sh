#!/usr/bin/env bash

puppet apply /opt/build/etc/puppet/manifests/run.pp

supervisord