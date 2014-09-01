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
    'libpspell-dev',
    'autoconf'
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

class php_5217_supervisor {
  file { '/etc/supervisor/conf.d/php-5.2.17.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.2.17.conf'
  }
}

class php_5217_extension_xdebug {
  include php_5217

  exec { 'pear download pecl/xdebug':
    cwd => '/tmp',
    path => ['/opt/phpfarm/inst/php-5.2.17/bin'],
    require => Class['php_5217']
  }

  exec { 'tar xzvf xdebug-2.2.5.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['pear download pecl/xdebug']
  }

  exec { '/bin/bash -l -c "phpize-5.2.17"':
    cwd => '/tmp/xdebug-2.2.5',
    require => Exec['tar xzvf xdebug-2.2.5.tgz']
  }

  exec { 'configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17':
    cwd => '/tmp/xdebug-2.2.5',
    path => ['/tmp/xdebug-2.2.5'],
    require => Exec['/bin/bash -l -c "phpize-5.2.17"']
  }

  exec { 'make':
    cwd => '/tmp/xdebug-2.2.5',
    path => ['/usr/bin'],
    require => Exec['configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17']
  }

  exec { 'make install':
    cwd => '/tmp/xdebug-2.2.5',
    path => ['/usr/bin'],
    require => Exec['make']
  }
}

class php_5217 {
  include phpfarm
  include php_5217_supervisor
  include php_5217_extension_xdebug

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
}

class php_5328_supervisor {
  file { '/etc/supervisor/conf.d/php-5.3.28.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.3.28.conf'
  }
}

class php_5328 {
  include phpfarm
  include php_5328_supervisor

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
}

class php_5328_fpm {
  include php_5328

  exec { '/bin/bash -c "cp /tmp/build/opt/phpfarm/src/custom-options-5.3.28-fpm.sh /opt/phpfarm/src/custom-options-5.3.28.sh"':
    require => Class['php_5328']
  }

  exec { '/bin/bash -l -c "rm -rf /opt/phpfarm/src/php-5.3.28 && /opt/phpfarm/src/compile.sh 5.3.28"':
    timeout => 0,
    require => Exec['/bin/bash -c "cp /tmp/build/opt/phpfarm/src/custom-options-5.3.28-fpm.sh /opt/phpfarm/src/custom-options-5.3.28.sh"']
  }
}

class php_5431_supervisor {
  file { '/etc/supervisor/conf.d/php-5.4.31.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.4.31.conf'
  }
}

class php_5431 {
  include phpfarm
  include php_5431_supervisor

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

  file { '/opt/phpfarm/inst/php-5.4.31/etc/php-fpm.conf':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/inst/php-5.4.31/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/opt/phpfarm/src/compile.sh 5.4.31']
  }
}

class php_5515_supervisor {
  file { '/etc/supervisor/conf.d/php-5.5.15.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.5.15.conf'
  }
}

class php_5515 {
  include phpfarm
  include php_5515_supervisor

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

  file { '/opt/phpfarm/inst/php-5.5.15/etc/php-fpm.conf':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/inst/php-5.5.15/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/opt/phpfarm/src/compile.sh 5.5.15']
  }
}

class php_apache2 {
  file { '/etc/apache2':
    ensure => present,
    recurse => true,
    source => '/tmp/build/etc/apache2'
  }
}

class php {
  include php_5217
#  include php_5328
#  include php_5328_fpm
#  include php_5431
#  include php_5515
#  include php_apache2

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => '/tmp/build/etc/profile.d/phpfarm.sh',
    mode => 755,
#    require => Class['php_5515']
  }

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

  Class['packages'] -> Class['php']

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}