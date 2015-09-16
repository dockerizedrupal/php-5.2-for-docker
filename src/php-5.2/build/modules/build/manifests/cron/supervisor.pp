class build::cron::supervisor {
  file { '/etc/supervisor/conf.d/cron.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/cron.conf',
    mode => 644
  }
}
