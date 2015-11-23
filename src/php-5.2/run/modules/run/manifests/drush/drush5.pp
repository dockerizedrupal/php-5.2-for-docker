class run::drush::drush5 {
  require run::user

  if $drush_version == '5' {
    file { '/usr/local/bin/drush':
      ensure => link,
      target => '/usr/local/src/drush5/drush'
    }

    file { '/etc/bash_completion.d/drush.complete.sh':
      ensure => link,
      target => '/usr/local/src/drush5/drush.complete.sh'
    }

    bash_exec { "chown -R -h $user_id /usr/local/src/drush5": }
    bash_exec { "chgrp -R -h $group_id /usr/local/src/drush5": }
  }
}
