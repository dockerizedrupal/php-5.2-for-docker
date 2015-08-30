class run::mysqld {
  bash_exec { 'mkdir -p /var/run/mysqld': }

  file { '/etc/supervisor/conf.d/mysqld.conf':
    ensure => present,
    content => template('run/mysqld.conf.erb'),
    mode => 644
  }
}
