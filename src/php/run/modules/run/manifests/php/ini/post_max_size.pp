class run::php::ini::post_max_size {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/post_max_size.ini':
    ensure => present,
    content => template('run/php/ini/post_max_size.ini.erb'),
    mode => 644
  }
}
