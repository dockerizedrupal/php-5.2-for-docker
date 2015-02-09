class php::drush {
  require php::drush::packages

  exec { 'mkdir /root/.drush':
    path => ['/bin']
  }

  file { '/tmp/drush-5.11.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-5.11.0.tar.gz'
  }

  exec { 'tar xzf drush-5.11.0.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/drush-5.11.0.tar.gz']
  }

  exec { 'mv drush-5.11.0 /opt/drush5':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf drush-5.11.0.tar.gz']
  }
}
