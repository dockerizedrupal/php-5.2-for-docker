class php::postfix::packages {
  package {[
      'postfix',
      'mailutils'
    ]:
    ensure => present
  }
}
