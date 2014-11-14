class ssmtp {
  file { '/etc/ssmtp/ssmtp.conf':
    ensure => present,
    content => template('ssmtp/ssmtp.conf.erb'),
    mode => 644
  }
}
