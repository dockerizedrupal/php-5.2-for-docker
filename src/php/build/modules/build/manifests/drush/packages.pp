class build::drush::packages {
  package {[
      'mysql-client'
    ]:
    ensure => present
  }
}
