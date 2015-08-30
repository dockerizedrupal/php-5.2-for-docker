class run::php::ini::xdebug {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/xdebug.ini':
    ensure => present,
    content => template('run/php/ini/xdebug.ini.erb'),
    mode => 644
  }
}
