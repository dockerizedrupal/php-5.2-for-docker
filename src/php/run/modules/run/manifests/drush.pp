class run::drush {
  if $drupal_version == '6' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush5/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush5/drush.complete.sh'
    }
  }
}
