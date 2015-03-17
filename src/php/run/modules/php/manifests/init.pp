define bash_exec (
  $command = $name,
  $user = 'root',
  $creates = undef,
  $cwd = undef,
  $environment = undef,
  $group = undef,
  $logoutput = undef,
  $onlyif = undef,
  $path = undef,
  $provider = "posix",
  $refresh = undef,
  $refreshonly = undef,
  $returns = undef,
  $timeout = undef,
  $tries = undef,
  $try_sleep = undef,
  $umask = undef,
  $unless = undef
) {
  $escaped_command = regsubst($command, "\"", "\\\"", 'G')

  if $unless == undef {
    $escaped_unless = undef
  } else {
    $unless_with_escaped_quotes = regsubst($unless, "\"", "\\\"", 'G')
    $escaped_unless = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${unless_with_escaped_quotes}\\\"\""
  }

  if $onlyif == undef {
    $escaped_onlyif = undef
  } else {
    $onlyif_with_escaped_quotes = regsubst($onlyif, "\"", "\\\"", 'G')
    $escaped_onlyif = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${onlyif_with_escaped_quotes}\\\"\""
  }

  exec { $name:
    command => "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${escaped_command}\\\"\"",
    creates => $creates,
    cwd => $cwd,
    environment => $environment,
    group => $group,
    logoutput => $logoutput,
    onlyif => $escaped_onlyif,
    path => $path,
    provider => $provider,
    refresh => $refresh,
    refreshonly => $refreshonly,
    returns => $returns,
    timeout => $timeout,
    tries => $tries,
    try_sleep => $try_sleep,
    umask => $umask,
    unless => $escaped_unless
  }
}

class php {
  include php::smtp

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

  include php::drush
  include php::coder

  file { '/usr/local/bin/phpfarm/inst/php-5.2.17/lib/php.ini':
    ensure => present,
    content => template('php/php.ini.erb')
  }

  file { '/root/.bashrc':
    ensure => present,
    content => template('php/.bashrc.erb')
  }
}
