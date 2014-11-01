class php::phpfarm {
  require php::packages

  exec { 'git clone https://github.com/fpoirotte/phpfarm.git phpfarm':
    cwd => '/',
    path => ['/usr/bin']
  }

  file { '/phpfarm/custom':
    ensure => directory,
    require => Exec['git clone https://github.com/fpoirotte/phpfarm.git phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
