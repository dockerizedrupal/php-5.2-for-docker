class php::drush::packages {
  package {[
      'mysql-client'
    ]:
    ensure => present
  }
}
