class php::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'ssmtp',
      'socat'
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}
