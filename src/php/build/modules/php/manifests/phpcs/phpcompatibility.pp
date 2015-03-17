class php::phpcs::phpcompatibility {
  file { '/tmp/PHPCompatibility-master.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/PHPCompatibility-master.zip'
  }

  bash_exec { 'cd /tmp && unzip PHPCompatibility-master.zip':
    require => File['/tmp/PHPCompatibility-master.zip']
  }

  bash_exec { 'mv /tmp/PHPCompatibility-master /usr/local/src/PHP_CodeSniffer/CodeSniffer/Standards/PHPCompatibility':
    require => Bash_exec['cd /tmp && unzip PHPCompatibility-master.zip']
  }
}
