class php::redis {
  file { '/etc/supervisor/conf.d/redis.conf':
    ensure => present,
    content => template('php/redis.conf.erb'),
    mode => 644
  }
}
