class run::smtp {
  file { '/etc/postfix/main.cf':
    ensure => present,
    content => template('run/main.cf.erb'),
    mode => 644
  }

  if $smtp_from {
    file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/sendmail.ini':
      ensure => present,
      content => template('run/php52/ini/sendmail.ini.erb'),
      mode => 644
    }
  }
}
