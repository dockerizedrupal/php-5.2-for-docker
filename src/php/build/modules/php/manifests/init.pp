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
  require php::packages
  require php::phpfarm
  require php::supervisor

  bash_exec { 'mkdir -p /usr/local/bin/phpfarm/inst/php-5.2.17/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/bin/phpfarm/inst/php-5.2.17/lib/php/extensions/no-debug-non-zts-20060613': }

  file { '/tmp/php-5.2.17.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.2.17.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf php-5.2.17.tar.gz':
    require => File['/tmp/php-5.2.17.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.2.17 /usr/local/bin/phpfarm/src/php-5.2.17':
    require => Bash_exec['cd /tmp && tar xzf php-5.2.17.tar.gz']
  }

  file { '/usr/local/bin/phpfarm/src/custom/options-5.2.17.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.2.17.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.2.17 /usr/local/bin/phpfarm/src/php-5.2.17']
  }

  bash_exec { '/usr/local/bin/phpfarm/src/main.sh 5.2.17':
    timeout => 0,
    require => File['/usr/local/bin/phpfarm/src/custom/options-5.2.17.sh']
  }

  bash_exec { 'rm -rf /usr/local/bin/phpfarm/src/php-5.2.17':
    require => Bash_exec['/usr/local/bin/phpfarm/src/main.sh 5.2.17']
  }

  file { '/usr/local/bin/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/bin/phpfarm/src/main.sh 5.2.17']
  }

  bash_exec { 'switch-phpfarm 5.2.17':
    require => Bash_exec['/usr/local/bin/phpfarm/src/main.sh 5.2.17']
  }
}
