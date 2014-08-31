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

class php52_supervisor {
  file { '/etc/supervisor/conf.d/php-5.2.17.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.2.17.conf'
  }
}

class php52_apache2 {
  file { '/etc/apache2/conf.d/php52-fcgi.conf':
    ensure => present,
    source => '/tmp/build/etc/apache2/conf.d/php52-fcgi.conf'
  }
}

class php52 {
  include phpfarm
  include php52_supervisor
  include php52_apache2

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

class php53_supervisor {
  file { '/etc/supervisor/conf.d/php-5.3.28.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.3.28.conf'
  }
}

class php53_apache2 {
  file { '/etc/apache2/conf.d/php53-fcgi.conf':
    ensure => present,
    source => '/tmp/build/etc/apache2/conf.d/php53-fcgi.conf'
  }
}

class php53 {
  include phpfarm
  include php53_supervisor
  include php53_apache2

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

class php54_supervisor {
  file { '/etc/supervisor/conf.d/php-5.4.31.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.4.31.conf'
  }
}

class php54_apache2 {
  file { '/etc/apache2/conf.d/php54-fcgi.conf':
    ensure => present,
    source => '/tmp/build/etc/apache2/conf.d/php54-fcgi.conf'
  }
}

class php54 {
  include phpfarm
  include php54_supervisor
  include php54_apache2

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

class php55_supervisor {
  file { '/etc/supervisor/conf.d/php-5.5.15.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.5.15.conf'
  }
}

class php55_apache2 {
  file { '/etc/apache2/conf.d/php55-fcgi.conf':
    ensure => present,
    source => '/tmp/build/etc/apache2/conf.d/php55-fcgi.conf'
  }
}

class php55 {
  include phpfarm
  include php55_supervisor
  include php55_apache2

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
  file { '/etc/apache2/conf.d/fastcgi.conf':
    ensure => present,
    source => '/tmp/build/etc/apache2/conf.d/fastcgi.conf'
  }
}

class php {
  include php52
  include php53
  include php53_fpm
  include php54
  include php55
  include php_apache2

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => '/tmp/build/etc/profile.d/phpfarm.sh',
    mode => 755,
    require => Class['php55']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.5.15"':
    require => File['/etc/profile.d/phpfarm.sh']
  }
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