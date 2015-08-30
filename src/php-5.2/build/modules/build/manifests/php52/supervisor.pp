class build::php52::supervisor {
  file { '/etc/supervisor/conf.d/php-5.2.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/php-5.2.conf',
    mode => 644
  }
}
