class run::redis {
  file { '/etc/supervisor/conf.d/redis.conf':
    ensure => present,
    content => template('run/redis.conf.erb'),
    mode => 644
  }
}
