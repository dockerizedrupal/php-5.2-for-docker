class php::post_max_size {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/post_max_size.ini':
    ensure => present,
    content => template('php/post_max_size.ini.erb'),
    mode => 644
  }
}
