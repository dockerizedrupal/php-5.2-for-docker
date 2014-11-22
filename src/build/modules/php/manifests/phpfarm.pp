class php::phpfarm {
  file { '/tmp/phpfarm-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/phpfarm-master.zip'
  }

  exec { 'unzip phpfarm-master.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/phpfarm-master.zip']
  }

  exec { 'mv phpfarm-master /phpfarm':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['unzip phpfarm-master.zip']
  }

  file { '/phpfarm/custom':
    ensure => directory,
    require => Exec['mv phpfarm-master /phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
