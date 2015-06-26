class build::php {
  require build::php::packages
  require build::php::supervisor
  require build::phpfarm
  require build::freetds

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.2.17/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.2.17/lib/php/extensions/no-debug-non-zts-20060613': }

  file { '/tmp/php-5.2.17.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/php-5.2.17.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf php-5.2.17.tar.gz':
    require => File['/tmp/php-5.2.17.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.2.17 /usr/local/src/phpfarm/src/php-5.2.17':
    require => Bash_exec['cd /tmp && tar xzf php-5.2.17.tar.gz']
  }

  file { '/usr/local/src/phpfarm/src/custom/options-5.2.17.sh':
    ensure => present,
    source => 'puppet:///modules/build/usr/local/src/phpfarm/src/custom/options-5.2.17.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.2.17 /usr/local/src/phpfarm/src/php-5.2.17']
  }

  bash_exec { '/usr/local/src/phpfarm/src/main.sh 5.2.17':
    timeout => 0,
    require => File['/usr/local/src/phpfarm/src/custom/options-5.2.17.sh']
  }

  bash_exec { 'rm -rf /usr/local/src/phpfarm/src/php-5.2.17':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.2.17']
  }

  file { '/usr/local/src/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/build/usr/local/src/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.2.17']
  }

  bash_exec { 'switch-phpfarm 5.2.17':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.2.17']
  }
}
