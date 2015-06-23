class php::memcached {
  if $memcached_host {
    file { '/etc/supervisor/conf.d/memcached.conf':
      ensure => present,
      content => template('php/memcached.conf.erb'),
      mode => 644
    }
  }

  if $memcached == "On" {
    file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/memcached.ini':
      ensure => present,
      content => template('php/memcached.ini.erb'),
      mode => 644
    }
  }
}
