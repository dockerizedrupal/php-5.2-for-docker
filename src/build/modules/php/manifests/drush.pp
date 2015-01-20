class php::drush {
  require php
  require php::extensions
  require php::drush::packages

  file { '/tmp/drush-5.x.zip':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-5.x.zip'
  }

  exec { 'unzip drush-5.x.zip':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => File['/tmp/drush-5.x.zip']
  }

  exec { 'mv drush-5.x /opt/drush':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['unzip drush-5.x.zip']
  }

  file { '/etc/bash_completion.d/drush.complete.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/bash_completion.d/drush.complete.sh',
    mode => 755
  }
}
