class run::cron::crontab::crontab_generator {
  require run::cron::crontab::crontab_generator::supervisor

  file { '/usr/local/bin/crontab_generator':
    ensure => present,
    content => template('run/crontab_generator.sh.erb'),
    mode => 755
  }
}
