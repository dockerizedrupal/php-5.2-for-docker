class php::supervisor {
  file { '/etc/supervisor/conf.d/php.conf':
    ensure => present,
    source => 'puppet:///modules/php/etc/supervisor/conf.d/php.conf'
  }
}
