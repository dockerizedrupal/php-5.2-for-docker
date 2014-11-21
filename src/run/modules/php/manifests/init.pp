class php {
  if $smtp_host {
    include php::ssmtp
  }

  if $db_host {
    include php::mysqld
  }
}
