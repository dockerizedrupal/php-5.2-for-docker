class php::timezone {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/timezone.ini':
    ensure => present,
    content => template('php/timezone.ini.erb'),
    mode => 644
  }
}
