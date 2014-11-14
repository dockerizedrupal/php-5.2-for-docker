class mysql {
  require mysql::packages

  file { '/etc/supervisor/conf.d/mysql.conf':
    ensure => present,
    content => template('mysql/mysql.conf.erb'),
    mode => 644
  }
}
