class build::cron::supervisor {
  file { '/etc/supervisor/conf.d/logs_cron.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/logs_cron.conf',
    mode => 644
  }
}
