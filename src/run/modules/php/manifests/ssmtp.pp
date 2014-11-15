class php::ssmtp {
  require php::packages

  file { '/etc/ssmtp/ssmtp.conf':
    ensure => present,
    content => template('php/ssmtp.conf.erb'),
    mode => 644
  }
}
