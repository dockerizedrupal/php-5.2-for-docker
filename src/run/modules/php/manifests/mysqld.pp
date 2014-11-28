class php::mysqld {
  exec { 'mkdir -p /var/run/mysqld':
    path => ['/bin']
  }

  file { '/etc/supervisor/conf.d/mysqld.conf':
    ensure => present,
    content => template('php/mysqld.conf.erb'),
    mode => 644
  }
}
