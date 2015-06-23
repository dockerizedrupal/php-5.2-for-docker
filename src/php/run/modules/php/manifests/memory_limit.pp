class php::memory_limit {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/memory_limit.ini':
    ensure => present,
    content => template('php/memory_limit.ini.erb'),
    mode => 644
  }
}
