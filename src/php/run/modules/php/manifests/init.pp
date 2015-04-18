class php {
  include php::smtp
  include php::drush
  include php::coder
  include php::phpcs

  if $mysqld_host {
    include php::mysqld
  }

  if $memcached_host {
    include php::memcached
  }

  if $redis_host {
    include php::redis
  }

  if $freetds_1_server_name {
    include php::freetds
  }

  file { '/usr/local/src/phpfarm/inst/php-5.2.17/lib/php.ini':
    ensure => present,
    content => template('php/php.ini.erb')
  }

  file { '/root/.bashrc':
    ensure => present,
    content => template('php/.bashrc.erb')
  }
}
