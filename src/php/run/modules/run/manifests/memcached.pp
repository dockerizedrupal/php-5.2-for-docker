class run::memcached {
  file { '/etc/supervisor/conf.d/memcached.conf':
    ensure => present,
    content => template('run/memcached.conf.erb'),
    mode => 644
  }
}
