class run::coder {
  if $drupal_version == '6' {
    file { '/home/container/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder6'
    }
  }
}
