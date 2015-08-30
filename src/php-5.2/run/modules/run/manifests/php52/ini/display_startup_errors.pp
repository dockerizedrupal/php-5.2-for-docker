class run::php52::ini::display_startup_errors {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/display_startup_errors.ini':
    ensure => present,
    content => template('run/php52/ini/display_startup_errors.ini.erb'),
    mode => 644
  }
}
