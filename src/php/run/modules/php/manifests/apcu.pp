class php::apcu {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/apcu.ini':
    ensure => present,
    content => template('php/apcu.ini.erb'),
    mode => 644
  }
}
