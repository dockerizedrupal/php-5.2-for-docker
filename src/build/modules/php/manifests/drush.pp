class php::drush {
  require php::drush::packages

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

  file { '/tmp/drush-6.5.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-6.5.0.tar.gz'
  }

  exec { 'tar xzf drush-6.5.0.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/drush-6.5.0.tar.gz']
  }

  exec { 'mv drush-6.5.0 /opt/drush6':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf drush-6.5.0.tar.gz']
  }

  file { '/tmp/drush-7.0.0-alpha8.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-7.0.0-alpha8.tar.gz'
  }

  exec { 'tar xzf drush-7.0.0-alpha8.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/drush-7.0.0-alpha8.tar.gz']
  }

  exec { 'mv drush-7.0.0-alpha8 /opt/drush7':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['tar xzf ddrush-7.0.0-alpha8.tar.gz']
  }
}
