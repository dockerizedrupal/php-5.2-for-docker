class php {
  if $ssmtp_host {
    include php::ssmtp
  }

  if $mysqld_host {
    include php::mysqld
  }
}
