class run::php52::ini::opcache {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/opcache.ini':
    ensure => present,
    content => template('run/php52/ini/opcache.ini.erb'),
    mode => 644
  }
}
