class run::cron::crontab::crontab_generator::supervisor {
  file { '/etc/supervisor/conf.d/crontab_generator.conf':
    ensure => present,
    source => 'puppet:///modules/run/etc/supervisor/conf.d/crontab_generator.conf',
    mode => 644
  }
}
