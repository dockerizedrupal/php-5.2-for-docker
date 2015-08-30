class run {
  require run::user

  include run::php
  include run::smtp
  include run::drush
  include run::coder
  include run::phpcs

  if $mysqld_host {
    include run::mysqld
  }

  if $memcached_host {
    include run::memcached
  }

  if $redis_host {
    include run::redis
  }

  if $freetds_1_server_name {
    include run::freetds
  }

  file { '/home/container/.bashrc':
    ensure => present,
    content => template('run/.bashrc.erb'),
    mode => 644
  }
}
