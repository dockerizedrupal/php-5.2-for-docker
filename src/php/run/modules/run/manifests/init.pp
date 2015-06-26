class run {
  require run::user

  include run::smtp
  include run::drush
  include run::coder
  include run::phpcs

  include run::php::ini::realpath_cache_size
  include run::php::ini::realpath_cache_ttl
  include run::php::ini::timezone
  include run::php::ini::post_max_size
  include run::php::ini::upload_max_filesize
  include run::php::ini::short_open_tag
  include run::php::ini::max_execution_time
  include run::php::ini::max_input_vars
  include run::php::ini::memory_limit
  include run::php::ini::display_errors
  include run::php::ini::display_startup_errors
  include run::php::ini::error_reporting
  include run::php::ini::expose_php
  include run::php::ini::allow_url_fopen

  if $php_ini_opcache == "On" {
    include run::php::ini::opcache
  }

  if $php_ini_xdebug == "On" {
    include run::php::ini::xdebug
  }

  if $php_ini_memcached == "On" {
    include run::php::ini::memcached
  }

  if $php_ini_memcached == "On" {
    include run::php::ini::redis
  }

  if $php_ini_apcu == "On" {
    include run::php::ini::apcu
  }

  if $php_ini_apd == "On" {
    include run::php::ini::apd
  }

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
