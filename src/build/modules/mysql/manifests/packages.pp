class mysql::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'socat'
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}
