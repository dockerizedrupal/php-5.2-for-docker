class php_5217_supervisor {
  file { '/etc/supervisor/conf.d/php-5.2.17.conf':
    ensure => present,
    source => '/tmp/build/etc/supervisor/conf.d/php-5.2.17.conf'
  }
}

class php_5217_extension_xdebug {
  include php_5217

  exec { 'pear download pecl/xdebug-2.2.5':
    cwd => '/tmp',
    path => ['/opt/phpfarm/inst/php-5.2.17/bin'],
    require => Class['php_5217']
  }

  exec { 'tar xzf xdebug-2.2.5.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['pear download pecl/xdebug']
  }

  exec { '/opt/phpfarm/inst/bin/phpize-5.2.17':
    cwd => '/tmp/xdebug-2.2.5',
    require => Exec['tar xzvf xdebug-2.2.5.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17"':
    require => Exec['/opt/phpfarm/inst/bin/phpize-5.2.17']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17"']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make"']
  }
}

class php_5217_libmemcached {
  include php_5217_extension_memcached

  exec { 'wget https://launchpad.net/libmemcached/1.0/0.53/+download/libmemcached-0.53.tar.gz':
    cwd => '/tmp',
    path => ['/usr/bin/'],
    before => Class['php_5217_extension_memcached']
  }

  exec { 'tar xzf libmemcached-0.53.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['wget https://launchpad.net/libmemcached/1.0/0.53/+download/libmemcached-0.53.tar.gz']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-0.53 && ./configure"':
    require => Exec['tar xzf libmemcached-0.53.tar.gz']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-0.53 && make"':
    require => Exec['/bin/bash -l -c "cd libmemcached-0.53 && ./configure"']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-0.53 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/libmemcached-0.53 && make"']
  }
}

class php_5217_extension_memcached {
  include php_5217
  include php_5217_libmemcached

  exec { 'pear download pecl/memcached-1.0.2':
    cwd => '/tmp',
    path => ['/opt/phpfarm/inst/php-5.2.17/bin'],
    require => Class['php_5217']
  }

  exec { 'tar xzf memcached-1.0.2.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['pear download pecl/memcached-1.0.2']
  }

  exec { '/opt/phpfarm/inst/bin/phpize-5.2.17':
    cwd => '/tmp/memcached-1.0.2',
    require => Exec['tar xzvf memcached-1.0.2.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-1.0.2 && ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17"':
    require => Exec['/opt/phpfarm/inst/bin/phpize-5.2.17']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-1.0.2 && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/memcached-1.0.2 && ./configure --with-php-config=/opt/phpfarm/inst/bin/php-config-5.2.17"']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-1.0.2 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/memcached-1.0.2 && make"']
  }
}

class php_5217 {
  include phpfarm
  include php_5217_supervisor
  include php_5217_extension_xdebug
  include php_5217_extension_memcached

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

  file { '/opt/phpfarm/inst/php-5.2.17/lib/php.ini':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/inst/php-5.2.17/lib/php.ini',
    mode => 644,
    require => Exec['/opt/phpfarm/src/compile.sh 5.2.17']
  }
}