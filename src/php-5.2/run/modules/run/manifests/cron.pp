class run::cron {
  require run::user

  include run::cron::crontab

  bash_exec { 'touch /var/log/cron.log': }

  bash_exec { 'chown container.container /var/log/cron.log':
    require => Bash_exec['touch /var/log/cron.log']
  }
}
