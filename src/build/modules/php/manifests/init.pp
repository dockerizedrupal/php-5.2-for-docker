class php {
  require php::packages
  require php::phpfarm
  require php::supervisor

  exec { 'mkdir -p /phpfarm/inst/php-5.2.17/lib/php/extensions/no-debug-non-zts-20060613':
    path => ['/bin']
  }

  file { '/tmp/php-5.2.17.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.2.17.tar.gz'
  }

  exec { 'tar xzf php-5.2.17.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/php-5.2.17.tar.gz']
  }

  exec { 'mv php-5.2.17 /phpfarm/src/php-5.2.17':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf php-5.2.17.tar.gz']
  }

  file { '/phpfarm/src/custom/options-5.2.17.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.2.17.sh',
    mode => 755,
    require => Exec['mv php-5.2.17 /phpfarm/src/php-5.2.17']
  }

  exec { '/phpfarm/src/main.sh 5.2.17':
    timeout => 0,
    require => File['/phpfarm/src/custom/options-5.2.17.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.2.17':
    path => ['/bin'],
    require => Exec['/phpfarm/src/main.sh 5.2.17']
  }

  file { '/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/main.sh 5.2.17']
  }

  exec { '/bin/su - root -mc "switch-phpfarm 5.2.17"':
    require => Exec['/phpfarm/src/main.sh 5.2.17']
  }
}
