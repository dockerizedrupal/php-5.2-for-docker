class run::smtp {
  file { '/etc/postfix/main.cf':
    ensure => present,
    content => template('run/main.cf.erb'),
    mode => 644
  }
}
