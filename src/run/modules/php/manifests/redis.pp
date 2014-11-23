class php::redis {
  require php::packages

  file { '/etc/supervisor/conf.d/redis.conf':
    ensure => present,
    content => template('php/redis.conf.erb'),
    mode => 644
  }
}
