class build::postfix::packages {
  package {[
      'postfix',
      'mailutils'
    ]:
    ensure => present
  }
}
