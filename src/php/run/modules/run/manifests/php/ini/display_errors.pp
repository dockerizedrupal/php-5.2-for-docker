class run::php::ini::display_errors {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/display_errors.ini':
    ensure => present,
    content => template('run/php/ini/display_errors.ini.erb'),
    mode => 644
  }
}
