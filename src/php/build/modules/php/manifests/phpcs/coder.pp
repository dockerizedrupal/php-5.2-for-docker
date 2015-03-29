class php::phpcs::coder {
  file { '/tmp/coder-6.x-2.0-rc1.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/coder-6.x-2.0-rc1.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf coder-6.x-2.0-rc1.tar.gz':
    require => File['/tmp/coder-6.x-2.0-rc1.tar.gz']
  }

  bash_exec { 'mv /tmp/coder /usr/local/src/coder6':
    require => Bash_exec['cd /tmp && tar xzf coder-6.x-2.0-rc1.tar.gz']
  }
}
