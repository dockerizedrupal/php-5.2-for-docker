class php::realpath_cache_size {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/realpath_cache_size.ini':
    ensure => present,
    content => template('php/realpath_cache_size.ini.erb'),
    mode => 644
  }
}
