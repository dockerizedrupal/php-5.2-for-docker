class run::php52::ini::display_errors {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/display_errors.ini':
    ensure => present,
    content => template('run/php52/ini/display_errors.ini.erb'),
    mode => 644
  }
}
