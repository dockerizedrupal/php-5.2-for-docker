class packages {
  package {[
    'git',
    'curl',
    'build-essential',
    'libxml2-dev',
    'libssl-dev',
    'libbz2-dev',
    'libcurl4-gnutls-dev',
    'libpng12-dev',
    'libmcrypt-dev',
    'libmhash-dev',
    'libmysqlclient-dev',
    'libpspell-dev'
  ]:
    ensure => present
  }
}

class phpfarm {
  include packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/opt',
    path => ['/usr/bin'],
    require => Class['packages']
  }
}

class php52 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.2.17.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.2.17.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.2.17':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.2.17.sh']
  }

  file { '/opt/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/opt/phpfarm/src/compile.sh 5.2.17']
  }

  file { '/etc/supervisor/conf.d/php-5.2.17.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.2.17.conf'
  }
}

class php53 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.3.28.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.3.28.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.3.28':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.3.28.sh']
  }

  file { '/opt/phpfarm/inst/php-5.3.28/etc/php-fpm.conf':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/inst/php-5.3.28/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/opt/phpfarm/src/compile.sh 5.3.28']
  }

  file { '/etc/supervisor/conf.d/php-5.3.28.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.3.28.conf'
  }
}

class php53_fpm {
  include php53

  exec { '/bin/bash -c "cp /tmp/build/opt/phpfarm/src/custom-options-5.3.28-fpm.sh /opt/phpfarm/src/custom-options-5.3.28.sh"':
    require => Class['php53']
  }

  exec { '/bin/bash -l -c "rm -rf /opt/phpfarm/src/php-5.3.28 && /opt/phpfarm/src/compile.sh 5.3.28"':
    timeout => 0,
    require => Exec['/bin/bash -c "cp /tmp/build/opt/phpfarm/src/custom-options-5.3.28-fpm.sh /opt/phpfarm/src/custom-options-5.3.28.sh"']
  }
}

class php54 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.4.31.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.4.31.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.4.31':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.4.31.sh']
  }
}

class php55 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.5.15.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.5.15.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.5.15':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.5.15.sh']
  }
}

class php {
#  include php52
#  include php53
#  include php53_fpm
  include php54
#  include php55
#
#  file { '/etc/profile.d/phpfarm.sh':
#    ensure => present,
#    source => '/tmp/build/etc/profile.d/phpfarm.sh',
#    mode => 755,
#    require => Class['php55']
#  }
#
#  exec { '/bin/bash -l -c "switch-phpfarm 5.5.15"':
#    require => File['/etc/profile.d/phpfarm.sh']
#  }
}

node default {
  file { '/run.sh':
    ensure => present,
    source => '/tmp/build/run.sh',
    mode => 755
  }

  include packages
  include php

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}