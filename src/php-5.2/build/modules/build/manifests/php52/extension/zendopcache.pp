class build::php52::extension::zendopcache {
  require build::php52

  file { '/tmp/zendopcache-7.0.3.tgz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/zendopcache-7.0.3.tgz'
  }

  bash_exec { 'cd /tmp && tar xzf zendopcache-7.0.3.tgz':
    require => File['/tmp/zendopcache-7.0.3.tgz']
  }

  bash_exec { 'cd /tmp/zendopcache-7.0.3 && phpize-5.2.17':
    require => Bash_exec['cd /tmp && tar xzf zendopcache-7.0.3.tgz']
  }

  bash_exec { 'cd /tmp/zendopcache-7.0.3 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.2.17':
    timeout => 0,
    require => Bash_exec['cd /tmp/zendopcache-7.0.3 && phpize-5.2.17']
  }

  bash_exec { 'cd /tmp/zendopcache-7.0.3 && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/zendopcache-7.0.3 && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.2.17']
  }

  bash_exec { 'cd /tmp/zendopcache-7.0.3 && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/zendopcache-7.0.3 && make']
  }
}
