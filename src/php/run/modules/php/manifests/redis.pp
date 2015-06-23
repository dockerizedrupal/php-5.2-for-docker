class php::redis {
  if $redis_host {
    file { '/etc/supervisor/conf.d/redis.conf':
      ensure => present,
      content => template('php/redis.conf.erb'),
      mode => 644
    }
  }

  if $redis == "On" {
    file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/redis.ini':
      ensure => present,
      content => template('php/redis.ini.erb'),
      mode => 644
    }
  }
}
