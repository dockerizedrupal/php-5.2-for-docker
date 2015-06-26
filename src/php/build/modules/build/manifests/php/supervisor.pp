class build::php::supervisor {
  file { '/etc/supervisor/conf.d/php.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/php.conf',
    mode => 644
  }
}
