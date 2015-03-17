class php::extension::memcached {
  require php
  require php::extension::igbinary

  file { '/tmp/libmemcached-1.0.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/libmemcached-1.0.18.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf libmemcached-1.0.18.tar.gz':
    require => File['/tmp/libmemcached-1.0.18.tar.gz']
  }

  bash_exec { 'cd /tmp/libmemcached-1.0.18 && ./configure':
    timeout => 0,
    require => Bash_exec['cd /tmp && tar xzf libmemcached-1.0.18.tar.gz']
  }

  bash_exec { 'cd /tmp/libmemcached-1.0.18 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/libmemcached-1.0.18 && ./configure']
  }

  bash_exec { 'cd /tmp/libmemcached-1.0.18 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/libmemcached-1.0.18 && make']
  }

  file { '/tmp/memcached-2.1.0.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/memcached-2.1.0.tgz',
    require => Bash_exec['cd /tmp/libmemcached-1.0.18 && make install']
  }

  bash_exec { 'cd /tmp && tar xzf memcached-2.1.0.tgz':
    require => File['/tmp/memcached-2.1.0.tgz']
  }

  bash_exec { 'cd /tmp/memcached-2.1.0 && phpize-5.2.17':
    require => Bash_exec['cd /tmp && tar xzf memcached-2.1.0.tgz']
  }

  bash_exec { 'cd /tmp/memcached-2.1.0 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.2.17 --enable-memcached-igbinary':
    timeout => 0,
    require => Bash_exec['cd /tmp/memcached-2.1.0 && phpize-5.2.17']
  }

  bash_exec { 'cd /tmp/memcached-2.1.0 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/memcached-2.1.0 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.2.17 --enable-memcached-igbinary']
  }

  bash_exec { 'cd /tmp/memcached-2.1.0 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/memcached-2.1.0 && make']
  }
}
