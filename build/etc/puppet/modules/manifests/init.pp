class packages {
    package {[
      'ssmtp'
    ]:
    ensure => present
  }
}

class ssmtp {
  include packages

  file { '/etc/ssmtp/ssmtp.conf':
    ensure => present,
    content => template('ssmtp/ssmtp.conf.erb'),
    mode => 644,
    require => Class['packages']
  }
}
