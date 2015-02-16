class php::smtp {
  file { '/etc/postfix/main.cf':
    ensure => present,
    content => template('php/main.cf.erb'),
    mode => 644
  }
}
