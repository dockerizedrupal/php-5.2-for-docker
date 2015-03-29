class php::postfix::supervisor {
  file { '/etc/supervisor/conf.d/postfix.conf':
    ensure => present,
    source => 'puppet:///modules/php/etc/supervisor/conf.d/postfix.conf',
    mode => 644
  }
}
