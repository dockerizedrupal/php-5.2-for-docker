class php::phpfarm {
  require php::packages

  file { '/phpfarm-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm-master.zip'
  }

  exec { 'unzip phpfarm-master.zip':
    cwd => '/',
    path => ['/usr/bin'],
    require => File['/phpfarm-master.zip']
  }

  exec { 'rm phpfarm-master.zip':
    cwd => '/',
    path => ['/bin'],
    require => Exec['unzip phpfarm-master.zip']
  }

  exec { 'mv phpfarm-master phpfarm':
    cwd => '/',
    path => ['/bin'],
    require => Exec['unzip phpfarm-master.zip']
  }

  file { '/phpfarm/custom':
    ensure => directory,
    require => Exec['mv phpfarm-master phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
