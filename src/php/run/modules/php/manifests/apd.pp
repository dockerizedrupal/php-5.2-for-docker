class php::apd {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/apd.ini':
    ensure => present,
    content => template('php/apd.ini.erb'),
    mode => 644
  }
}
