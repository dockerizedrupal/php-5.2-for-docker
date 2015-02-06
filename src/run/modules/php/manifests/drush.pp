class php::drush {
  if $drush_version == '5' {
    file { '/opt/drush5/drush':
      ensure => link,
      target => '/usr/local/bin/drush'
    }

    file { '/opt/drush5/drush.complete.sh':
      ensure => link,
      target => '/etc/bash_completion.d/drush.complete.sh'
    }
  }

  if $drush_version == '6' {
    file { '/opt/drush6/drush':
      ensure => link,
      target => '/usr/local/bin/drush'
    }

    file { '/opt/drush6/drush.complete.sh':
      ensure => link,
      target => '/etc/bash_completion.d/drush.complete.sh'
    }
  }

  if $drush_version == '7' {
    file { '/opt/drush7/drush':
      ensure => link,
      target => '/usr/local/bin/drush'
    }

    file { '/opt/drush7/drush.complete.sh':
      ensure => link,
      target => '/etc/bash_completion.d/drush.complete.sh'
    }
  }
}
