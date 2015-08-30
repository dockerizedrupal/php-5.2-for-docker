class run::php::ini::opcache {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/opcache.ini':
    ensure => present,
    content => template('run/php/ini/opcache.ini.erb'),
    mode => 644
  }
}
