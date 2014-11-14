class mysql::packages {
  package {[
      'socat'
    ]:
    ensure => present
  }
}
