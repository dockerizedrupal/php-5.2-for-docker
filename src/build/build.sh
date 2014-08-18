#!/usr/bin/env bash

puppet module install puppetlabs-apt

puppet apply /opt/build/etc/puppet/manifests/build.pp

rm /opt/build/etc/puppet/manifests/build.pp

cp /opt/build/etc/puppet/manifests/run.pp /etc/puppet/manifests/run.pp

apt-get install -y git
apt-get install -y build-essential
apt-get install -y libxml2-dev
apt-get install -y libssl-dev
apt-get install -y libbz2-dev
apt-get install -y libcurl4-gnutls-dev
apt-get install -y libpng12-dev
apt-get install -y libmcrypt-dev
apt-get install -y libmhash-dev
apt-get install -y libmysqlclient-dev
apt-get install -y libpspell-dev

git clone git://git.code.sf.net/p/phpfarm/code /opt/phpfarm

cp /opt/build/opt/phpfarm/src/custom-options-5.2.17.sh /opt/phpfarm/src/custom-options-5.2.17.sh
/opt/phpfarm/src/compile.sh 5.2.17

cp /opt/build/opt/phpfarm/src/custom-options-5.3.28.sh /opt/phpfarm/src/custom-options-5.3.28.sh
/opt/phpfarm/src/compile.sh 5.3.28

cp /opt/build/opt/phpfarm/src/custom-options-5.4.30.sh /opt/phpfarm/src/custom-options-5.4.30.sh
/opt/phpfarm/src/compile.sh 5.4.30

cp /opt/build/opt/phpfarm/src/custom-options-5.5.14.sh /opt/phpfarm/src/custom-options-5.5.14.sh
/opt/phpfarm/src/compile.sh 5.5.14

rm -rf /opt/phpfarm/src