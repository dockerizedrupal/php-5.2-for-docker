class php {
  if $smtp_host {
    include php::ssmtp
  }

  if $db_host {
    include php::mysqld
  }

  if $memcached_host {
    include php::memcached
  }

  if $redis_host {
    include php::redis
  }
}
