class build::php52::extension::zend_debugger {
  require build::php52

  file { '/usr/local/src/phpfarm/inst/current/lib/php/extensions/no-debug-non-zts-20060613/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/build/tmp/ZendDebugger.so'
  }
}
