class php::phpcs {
  require php

  file { '/tmp/PHP_CodeSniffer-1.5.6.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/PHP_CodeSniffer-1.5.6.tar.gz'
  }

  exec { 'tar xzf PHP_CodeSniffer-1.5.6.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/PHP_CodeSniffer-1.5.6.tar.gz']
  }

  exec { 'mv PHP_CodeSniffer-1.5.6 /opt/PHP_CodeSniffer':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf PHP_CodeSniffer-1.5.6.tar.gz']
  }
}
