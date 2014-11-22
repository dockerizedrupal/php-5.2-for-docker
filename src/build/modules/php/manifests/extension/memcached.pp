class php::extension::memcached {
  require php

  file { '/tmp/libmemcached-1.0.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/libmemcached-1.0.18.tar.gz'
  }

  exec { 'tar xzf libmemcached-1.0.18.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/libmemcached-1.0.18.tar.gz']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && ./configure"':
    require => Exec['tar xzf libmemcached-1.0.18.tar.gz']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && ./configure"']
  }

  exec { '/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && make"']
  }

  file { '/tmp/memcached-2.2.0.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/memcached-2.2.0.tgz',
    require => Exec['/bin/bash -l -c "cd /tmp/libmemcached-1.0.18 && make install"']
  }

  exec { 'tar xzf memcached-2.2.0.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/memcached-2.2.0.tgz']
  }

  exec { 'phpize-5.2.17 memcached':
    command => '/phpfarm/inst/bin/phpize-5.2.17',
    cwd => '/tmp/memcached-2.2.0',
    require => Exec['tar xzf memcached-2.2.0.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-2.2.0 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"':
    require => Exec['phpize-5.2.17 memcached']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-2.2.0 && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/memcached-2.2.0 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"']
  }

  exec { '/bin/bash -l -c "cd /tmp/memcached-2.2.0 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/memcached-2.2.0 && make"']
  }
}
