class php::opcache {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/opcache.ini':
    ensure => present,
    content => template('php/opcache.ini.erb'),
    mode => 644
  }
}
