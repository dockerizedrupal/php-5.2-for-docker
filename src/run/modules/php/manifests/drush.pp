class php::drush {
  if $drush_version == '5' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/opt/drush5/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/opt/drush5/drush.complete.sh'
    }
  }
}
