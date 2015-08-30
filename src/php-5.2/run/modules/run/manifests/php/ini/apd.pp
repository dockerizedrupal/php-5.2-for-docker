class run::php::ini::apd {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/apd.ini':
    ensure => present,
    content => template('run/php/ini/apd.ini.erb'),
    mode => 644
  }
}
