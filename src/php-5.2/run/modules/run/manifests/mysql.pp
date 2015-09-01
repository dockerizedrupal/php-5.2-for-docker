class run::mysql {
  bash_exec { 'mkdir -p /var/run/mysqld': }

  file { '/etc/supervisor/conf.d/mysql.conf':
    ensure => present,
    content => template('run/mysql.conf.erb'),
    mode => 644
  }
}
