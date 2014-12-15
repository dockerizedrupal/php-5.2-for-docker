class php::drush {
  require php
  require php::drush::packages

  file { '/root/.bashrc':
    ensure => present,
    source => 'puppet:///modules/php/root/.bashrc',
    mode => 644
  }

  exec { '/bin/su - root -c "composer global require drush/drush:6.*"':
    timeout => 0,
    require => File['/root/.bashrc']
  }

  file { '/etc/bash_completion.d/drush.complete.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/bash_completion.d/drush.complete.sh',
    mode => 755
  }
}
