class build::drush::drush5 {
  require build::user
  require build::drush::packages

  file { '/tmp/drush-5.11.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/build/tmp/drush-5.11.0.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf drush-5.11.0.tar.gz':
    require => File['/tmp/drush-5.11.0.tar.gz']
  }

  bash_exec { 'mv /tmp/drush-5.11.0 /usr/local/src/drush5':
    require => Bash_exec['cd /tmp && tar xzf drush-5.11.0.tar.gz']
  }
}
