class php::phpfarm {
  file { '/tmp/phpfarm-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/phpfarm-master.zip'
  }

  bash_exec { 'cd /tmp && unzip phpfarm-master.zip':
    require => File['/tmp/phpfarm-master.zip']
  }

  bash_exec { 'mv /tmp/phpfarm-master /usr/local/bin/phpfarm':
    require => Bash_exec['cd /tmp && unzip phpfarm-master.zip']
  }

  file { '/usr/local/bin/phpfarm/custom':
    ensure => directory,
    require => Bash_exec['mv /tmp/phpfarm-master /usr/local/bin/phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
