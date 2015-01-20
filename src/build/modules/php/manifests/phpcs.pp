class php::phpcs {
  require php

  file { '/tmp/PHP_CodeSniffer-2.1.0.tgz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/PHP_CodeSniffer-2.1.0.tgz'
  }

  exec { 'tar xzf PHP_CodeSniffer-2.1.0.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/PHP_CodeSniffer-2.1.0.tgz']
  }

  exec { 'mv PHP_CodeSniffer-2.1.0 /opt/PHP_CodeSniffer':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf PHP_CodeSniffer-2.1.0.tgz']
  }
}
