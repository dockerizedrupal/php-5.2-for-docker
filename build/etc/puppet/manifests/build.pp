class packages {
  package {[
    'git',
    'build-essential',
    'libxml2-dev',
    'libssl-dev',
    'libbz2-dev',
    'libcurl4-gnutls-dev',
    'libpng12-dev',
    'libmcrypt-dev',
    'libmhash-dev',
    'libmysqlclient-dev',
    'libpspell-dev'
  ]:
    ensure => present
  }
}

class phpfarm {
  include packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/opt',
    path => ['/usr/bin'],
    require => Class['packages']
  }
}

class php52 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.2.17.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.2.17.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.2.17':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.2.17.sh']
  }
}

class php53 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.3.28.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.3.28.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.3.28':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.3.28.sh']
  }
}

class php54 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.4.30.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.4.30.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.4.30':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.4.30.sh']
  }
}

class php55 {
  include phpfarm

  file { '/opt/phpfarm/src/custom-options-5.5.14.sh':
    ensure => present,
    source => '/tmp/build/opt/phpfarm/src/custom-options-5.4.14.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/opt/phpfarm/src/compile.sh 5.5.14':
    timeout => 0,
    require => File['/opt/phpfarm/src/custom-options-5.5.14.sh']
  }
}

class php {
  include php55

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => '/tmp/build/etc/profile.d/phpfarm.sh',
    mode => 755,
    require => Class['php55']
  }

  exec { '/bin/bash -c "source /etc/profile.d/phpfarm.sh && switch-phpfarm 5.5.14"':
    require => File['/etc/profile.d/phpfarm.sh']
  }
}

node default {
  file { '/run.sh':
    ensure => present,
    source => '/tmp/build/run.sh',
    mode => 755
  }

  include packages

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}