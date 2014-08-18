#!/usr/bin/env bash

apt-get install -y git
apt-get install -y wget
apt-get install -y libmcrypt-dev

apt-get install build-essential

apt-get build-dep -y php5

git clone git://git.code.sf.net/p/phpfarm/code /opt/phpfarm

cp /opt/build/opt/phpfarm/src/custom-options-5.2.17.sh /opt/phpfarm/src/custom-options-5.2.17.sh

/opt/phpfarm/src/compile.sh 5.2.17

# ADD ./src/opt/phpfarm/src/custom-options-5.3.28.sh /opt/phpfarm/src/custom-options-5.3.28.sh
# RUN /opt/phpfarm/src/compile.sh 5.3.28

# ADD ./src/opt/phpfarm/src/custom-options-5.4.30.sh /opt/phpfarm/src/custom-options-5.4.30.sh
# RUN /opt/phpfarm/src/compile.sh 5.4.30

# ADD ./src/opt/phpfarm/src/custom-options-5.5.14.sh /opt/phpfarm/src/custom-options-5.5.14.sh
# RUN /opt/phpfarm/src/compile.sh 5.5.14

rm -rf /opt/phpfarm/src