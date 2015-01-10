class php::extension::apd {
  require php

  file { '/tmp/apd-1.0.1.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/apd-1.0.1.tgz'
  }

  exec { 'tar xzf apd-1.0.1.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/apd-1.0.1.tgz']
  }

  file { '/tmp/file.patch':
    ensure => present,
    source => 'puppet:///modules/php/tmp/file.patch',
    require => Exec['tar xzf apd-1.0.1.tgz']
  }

  exec { 'patch < /tmp/file.patch':
    cwd => '/tmp/apd-1.0.1',
    path => ['/usr/bin'],
    require => File['/tmp/file.patch']
  }

  exec { 'phpize-5.2.17 apd':
    command => '/phpfarm/inst/bin/phpize-5.2.17',
    cwd => '/tmp/apd-1.0.1',
    require => Exec['patch < /tmp/file.patch']
  }

  exec { '/bin/su - root -mc "cd /tmp/apd-1.0.1 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"':
    timeout => 0,
    require => Exec['phpize-5.2.17 apd']
  }

  exec { '/bin/su - root -mc "cd /tmp/apd-1.0.1 && make"':
    timeout => 0,
    require => Exec['/bin/su - root -mc "cd /tmp/apd-1.0.1 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.2.17"']
  }

  exec { '/bin/su - root -mc "cd /tmp/apd-1.0.1 && make install"':
    timeout => 0,
    require => Exec['/bin/su - root -mc "cd /tmp/apd-1.0.1 && make"']
  }
}
