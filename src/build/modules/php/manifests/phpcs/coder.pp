class php::phpcs::coder {
  require php::phpcs
  require php::drush

  file { '/tmp/coder-7.x-2.4.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/coder-7.x-2.4.tar.gz'
  }

  exec { 'tar xzf coder-7.x-2.4.tar.gz':
    cwd => '/tmp',
    path => ['/bin'],
    require => File['/tmp/coder-7.x-2.4.tar.gz']
  }

  exec { 'mv /tmp/coder /root/.drush/coder':
    path => ['/bin'],
    require => Exec['tar xzf coder-7.x-2.4.tar.gz']
  }

  file { '/opt/PHP_CodeSniffer/CodeSniffer/Standards/Drupal':
    ensure => link,
    target => '/root/.drush/coder/coder_sniffer/Drupal',
    require => Exec['mv /tmp/coder /root/.drush/coder']
  }
}
