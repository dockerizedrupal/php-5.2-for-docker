class run::cron {
  require run::user

  if $cron == "On" {
    include run::cron::crontab

    bash_exec { 'touch /var/log/cron.log': }

    bash_exec { 'chown container.container /var/log/cron.log':
      require => Bash_exec['touch /var/log/cron.log']
    }
  }
  else {
    file { '/etc/supervisor/conf.d/cron.conf':
      ensure => 'absent',
      purge => true,
      force => true
    }

    file { '/etc/supervisor/conf.d/logs_cron.conf':
      ensure => 'absent',
      purge => true,
      force => true
    }
  }
}
