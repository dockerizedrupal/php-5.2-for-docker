class run::cron::crontab {
  if $crontab_1_expression and $crontab_1_command {
    file { '/etc/cron.d/crontab_1':
      ensure => present,
      content => template('run/crontab_1.erb'),
      mode => 644
    }
  }

  if $crontab_2_expression and $crontab_2_command {
    file { '/etc/cron.d/crontab_2':
      ensure => present,
      content => template('run/crontab_2.erb'),
      mode => 644
    }
  }

  if $crontab_3_expression and $crontab_3_command {
    file { '/etc/cron.d/crontab_3':
      ensure => present,
      content => template('run/crontab_3.erb'),
      mode => 644
    }
  }
}
