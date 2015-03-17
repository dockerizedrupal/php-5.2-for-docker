class php::drush {
  require php::drush::packages

  bash_exec { 'mkdir /root/.drush': }

  file { '/tmp/drush-5.11.0.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/drush-5.11.0.tar.gz'
  }

  bash_exec { 'cd /tmp && tar xzf drush-5.11.0.tar.gz':
    require => File['/tmp/drush-5.11.0.tar.gz']
  }

  bash_exec { 'mv /tmp/drush-5.11.0 /usr/local/src/drush5':
    require => Bash_exec['cd /tmp && tar xzf drush-5.11.0.tar.gz']
  }
}
