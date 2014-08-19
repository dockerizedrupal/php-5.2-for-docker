#!/usr/bin/env bash

puppet module install puppetlabs-apt

puppet apply /tmp/build/etc/puppet/manifests/build.pp

git clone git://git.code.sf.net/p/phpfarm/code /opt/phpfarm

cp /tmp/build/opt/phpfarm/src/custom-options-5.2.17.sh /opt/phpfarm/src/custom-options-5.2.17.sh
/opt/phpfarm/src/compile.sh 5.2.17

cp /tmp/build/opt/phpfarm/src/custom-options-5.3.28.sh /opt/phpfarm/src/custom-options-5.3.28.sh
/opt/phpfarm/src/compile.sh 5.3.28

cp /tmp/build/opt/phpfarm/src/custom-options-5.4.30.sh /opt/phpfarm/src/custom-options-5.4.30.sh
/opt/phpfarm/src/compile.sh 5.4.30

cp /tmp/build/opt/phpfarm/src/custom-options-5.5.14.sh /opt/phpfarm/src/custom-options-5.5.14.sh
/opt/phpfarm/src/compile.sh 5.5.14

#rm -rf /opt/phpfarm/src