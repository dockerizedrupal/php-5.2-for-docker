class ssmtp::packages {
  exec { 'apt-get update':
    path => ['/usr/bin']
  }

  package {[
      'ssmtp'
    ]:
    ensure => present,
    require => Exec['apt-get update']
  }
}
