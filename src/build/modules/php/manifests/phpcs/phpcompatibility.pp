class php::phpcs::phpcompatibility {
  require php::phpcs

  file { '/tmp/PHPCompatibility-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/PHPCompatibility-master.zip'
  }

  exec { 'unzip PHPCompatibility-master.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/PHPCompatibility-master.zip']
  }

  exec { 'mv /tmp/PHPCompatibility-master /opt/PHP_CodeSniffer/CodeSniffer/Standards/PHPCompatibility':
    path => ['/bin'],
    require => Exec['unzip PHPCompatibility-master.zip']
  }
}
