class run::phpcs {
  file { '/etc/profile.d/phpcs.sh':
    ensure => present,
    content => template('run/phpcs.sh.erb'),
    mode => 755
  }
}
