class packages {
  package {[
      'git',
      'curl',
      'build-essential',
      'libxml2-dev',
      'libssl-dev',
      'libbz2-dev',
      'libcurl4-gnutls-dev',
      'libjpeg-dev',
      'libpng12-dev',
      'libmcrypt-dev',
      'libmhash-dev',
      'libmysqlclient-dev',
      'libpspell-dev',
      'autoconf',
      'libcloog-ppl0'
    ]:
    ensure => present
  }
}

class phpfarm {
  include packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin'],
    require => Class['packages']
  }
}

class php_supervisor {
  file { '/etc/supervisor/conf.d/php.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php.conf'
  }
}

class php_extension_xdebug {
  include php

  exec { 'git clone https://github.com/xdebug/xdebug.git':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => Class['php']
  }

  exec { 'phpize-5.2.17 xdebug':
    command => '/phpfarm/inst/bin/phpize-5.2.17',
    cwd => '/tmp/xdebug',
    require => Exec['git clone https://github.com/xdebug/xdebug.git']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"':
    require => Exec['phpize-5.2.17 xdebug']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug && make"']
  }
}

class php {
  include phpfarm
  include php_supervisor
  include php_extension_xdebug

  file { '/phpfarm/src/custom-options-5.2.17.sh':
    ensure => present,
    source => '/tmp/build/phpfarm/src/custom-options-5.2.17.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/phpfarm/src/compile.sh 5.2.17':
    timeout => 0,
    require => File['/phpfarm/src/custom-options-5.2.17.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.2.17':
    path => ['/bin'],
    require => Exec['/phpfarm/src/compile.sh 5.2.17']
  }

  file { '/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    source => '/tmp/build/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.2.17']
  }

  file { '/phpfarm/inst/php-5.2.17/lib/php.ini':
    ensure => present,
    source => '/tmp/build/phpfarm/inst/php-5.2.17/lib/php.ini',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.2.17']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => '/tmp/build/etc/profile.d/phpfarm.sh',
    mode => 755,
    require => Exec['/phpfarm/src/compile.sh 5.2.17']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.2.17"':
    require => File['/etc/profile.d/phpfarm.sh']
  }
}

node default {
  file { '/etc/puppet/manifests':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    source => '/tmp/build/etc/puppet/manifests',
    mode => 644,
  }

  file { '/etc/puppet/modules':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    source => '/tmp/build/etc/puppet/modules',
    mode => 644,
  }

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
