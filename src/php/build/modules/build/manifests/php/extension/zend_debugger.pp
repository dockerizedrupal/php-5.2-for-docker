class build::php::extension::zend_debugger {
  require build::php

  file { '/usr/local/src/phpfarm/inst/current/lib/php/extensions/no-debug-non-zts-20060613/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/build/tmp/ZendDebugger.so'
  }
}
