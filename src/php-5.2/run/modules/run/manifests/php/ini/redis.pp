class run::php::ini::redis {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/redis.ini':
    ensure => present,
    content => template('run/php/ini/redis.ini.erb'),
    mode => 644
  }
}
