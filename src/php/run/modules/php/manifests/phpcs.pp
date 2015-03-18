class php::phpcs {
  file { '/etc/profile.d/phpcs.sh':
    ensure => present,
    content => template('php/phpcs.sh.erb'),
    mode => 755
  }
}
