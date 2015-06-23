class php::max_execution_time {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/max_execution_time.ini':
    ensure => present,
    content => template('php/max_execution_time.ini.erb'),
    mode => 644
  }
}
