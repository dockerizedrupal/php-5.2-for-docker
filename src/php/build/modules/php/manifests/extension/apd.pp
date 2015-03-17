class php::extension::apd {
  require php

  file { '/tmp/apd-1.0.1.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/apd-1.0.1.tgz'
  }

  bash_exec { 'cd /tmp && tar xzf apd-1.0.1.tgz':
    require => File['/tmp/apd-1.0.1.tgz']
  }

  file { '/tmp/file.patch':
    ensure => present,
    source => 'puppet:///modules/php/tmp/file.patch',
    require => Bash_exec['cd /tmp && tar xzf apd-1.0.1.tgz']
  }

  bash_exec { 'cd /tmp/apd-1.0.1 && patch < /tmp/file.patch':
    require => File['/tmp/file.patch']
  }

  bash_exec { 'cd /tmp/apd-1.0.1 && phpize-5.2.17':
    require => Bash_exec['cd /tmp/apd-1.0.1 && patch < /tmp/file.patch']
  }

  bash_exec { 'cd /tmp/apd-1.0.1 && ./configure --with-php-config=/usr/local/bin/phpfarm/inst/bin/php-config-5.2.17':
    timeout => 0,
    require => Bash_exec['cd /tmp/apd-1.0.1 && phpize-5.2.17']
  }

  bash_exec { 'cd /tmp/apd-1.0.1 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/apd-1.0.1 && ./configure --with-php-config=/usr/local/bin/phpfarm/inst/bin/php-config-5.2.17']
  }

  bash_exec { 'cd /tmp/apd-1.0.1 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/apd-1.0.1 && make']
  }
}
