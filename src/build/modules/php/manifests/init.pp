class php {
  require php::packages
  require php::supervisor

  exec { 'git clone https://github.com/fpoirotte/phpfarm.git phpfarm':
    cwd => '/',
    path => ['/usr/bin']
  }

  file { '/phpfarm/custom':
    ensure => directory,
    mode => 755,
    require => Exec['git clone https://github.com/fpoirotte/phpfarm.git phpfarm']
  }

  file { '/phpfarm/src/custom/options-5.2.17.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.2.17.sh',
    mode => 755,
    require => File['/phpfarm/custom']
  }
#
#  exec { '/phpfarm/src/main.sh 5.2.17':
#    timeout => 0,
#    require => File['/phpfarm/src/custom/options-5.2.17.sh']
#  }
#
#  exec { 'rm -rf /phpfarm/src/php-5.2.17':
#    path => ['/bin'],
#    require => Exec['/phpfarm/src/main.sh 5.2.17']
#  }
#
#  file { '/phpfarm/inst/php-5.2.17/etc/php-fpm.conf':
#    ensure => present,
#    source => 'puppet:///modules/php/phpfarm/inst/php-5.2.17/etc/php-fpm.conf',
#    mode => 644,
#    require => Exec['/phpfarm/src/main.sh 5.2.17']
#  }
#
#  file { '/phpfarm/inst/php-5.2.17/lib/php.ini':
#    ensure => present,
#    source => 'puppet:///modules/php/phpfarm/inst/php-5.2.17/lib/php.ini',
#    mode => 644,
#    require => Exec['/phpfarm/src/main.sh 5.2.17']
#  }
#
#  file { '/etc/profile.d/phpfarm.sh':
#    ensure => present,
#    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
#    mode => 755,
#    require => Exec['/phpfarm/src/main.sh 5.2.17']
#  }
#
#  exec { '/bin/bash -l -c "switch-phpfarm 5.2.17"':
#    require => File['/etc/profile.d/phpfarm.sh']
#  }
}
