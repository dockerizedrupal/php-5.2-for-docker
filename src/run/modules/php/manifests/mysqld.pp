class php::mysqld {
  bash_exec { 'mkdir -p /var/run/mysqld': }

  file { '/etc/supervisor/conf.d/mysqld.conf':
    ensure => present,
    content => template('php/mysqld.conf.erb'),
    mode => 644
  }
}
