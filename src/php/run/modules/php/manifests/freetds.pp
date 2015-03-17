class php::freetds {
  file { '/usr/local/freetds/etc/freetds.conf':
    ensure => present,
    content => template('php/freetds.conf.erb'),
    mode => 644
  }
}
