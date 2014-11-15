class php::mysql {
  require php::packages

  file { '/etc/supervisor/conf.d/mysql.conf':
    ensure => present,
    content => template('php/mysql.conf.erb'),
    mode => 644
  }
}
