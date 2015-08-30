class build::phpfarm {
  file { '/tmp/phpfarm-0.2.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/phpfarm-0.2.0.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf phpfarm-0.2.0.tar.gz':
    require => File['/tmp/phpfarm-0.2.0.tar.gz']
  }

  bash_exec { 'mv /tmp/phpfarm-0.2.0 /usr/local/src/phpfarm':
    require => Bash_exec['cd /tmp && tar xzf phpfarm-0.2.0.tar.gz']
  }

  file { '/usr/local/src/phpfarm/custom':
    ensure => directory,
    require => Bash_exec['mv /tmp/phpfarm-0.2.0 /usr/local/src/phpfarm']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/build/etc/profile.d/phpfarm.sh',
    mode => 755
  }
}
