class run {
  require run::user

  include run::php52
  include run::smtp
  include run::drush
  include run::coder
  include run::phpcs
  include run::timezone
  include run::cron

  if $mysql_host {
    include run::mysql
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
