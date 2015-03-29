class php::coder {
  if $drupal_version == '6' {
    file { '/root/.drush/coder':
      ensure => link,
      target => '/usr/local/src/coder6'
    }
  }
}
