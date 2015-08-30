class build::postfix::supervisor {
  file { '/etc/supervisor/conf.d/postfix.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/postfix.conf',
    mode => 644
  }
}
