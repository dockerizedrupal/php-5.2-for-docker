class php::phpcs {
  require php

  file { '/tmp/PHP_CodeSniffer-1.5.6.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/PHP_CodeSniffer-1.5.6.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf PHP_CodeSniffer-1.5.6.tar.gz':
    require => File['/tmp/PHP_CodeSniffer-1.5.6.tar.gz']
  }

  bash_exec { 'mv /tmp/PHP_CodeSniffer-1.5.6 /opt/PHP_CodeSniffer':
    require => Bash_exec['cd /tmp && tar xzf PHP_CodeSniffer-1.5.6.tar.gz']
  }
}
