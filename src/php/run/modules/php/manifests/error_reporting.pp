class php::error_reporting {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/error_reporting.ini':
    ensure => present,
    content => template('php/error_reporting.ini.erb'),
    mode => 644
  }
}
