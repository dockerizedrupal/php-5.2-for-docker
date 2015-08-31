class run::php52 {
  file { '/usr/local/src/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    content => template('run/php-fpm.conf.erb'),
    mode => 644
  }

  include run::php52::ini::realpath_cache_size
  include run::php52::ini::realpath_cache_ttl
  include run::php52::ini::timezone
  include run::php52::ini::post_max_size
  include run::php52::ini::upload_max_filesize
  include run::php52::ini::short_open_tag
  include run::php52::ini::max_execution_time
  include run::php52::ini::max_input_vars
  include run::php52::ini::memory_limit
  include run::php52::ini::display_errors
  include run::php52::ini::display_startup_errors
  include run::php52::ini::error_reporting
  include run::php52::ini::expose_php
  include run::php52::ini::allow_url_fopen

  if $php_ini_opcache == "On" {
    include run::php52::ini::opcache
  }

  if $php_ini_xdebug == "On" {
    include run::php52::ini::xdebug
  }

  if $php_ini_memcached == "On" {
    include run::php52::ini::memcached
  }

  if $php_ini_redis == "On" {
    include run::php52::ini::redis
  }

  if $php_ini_apcu == "On" {
    include run::php52::ini::apcu
  }

  if $php_ini_apd == "On" {
    include run::php52::ini::apd
  }
}
