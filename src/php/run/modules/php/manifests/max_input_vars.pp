class php::max_input_vars {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/max_input_vars.ini':
    ensure => present,
    content => template('php/max_input_vars.ini.erb'),
    mode => 644
  }
}
