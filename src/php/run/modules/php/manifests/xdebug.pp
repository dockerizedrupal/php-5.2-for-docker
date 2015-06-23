class php::xdebug {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/xdebug.ini':
    ensure => present,
    content => template('php/xdebug.ini.erb'),
    mode => 644
  }
}
