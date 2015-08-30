class run::php::ini::realpath_cache_ttl {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/realpath_cache_ttl.ini':
    ensure => present,
    content => template('run/php/ini/realpath_cache_ttl.ini.erb'),
    mode => 644
  }
}
