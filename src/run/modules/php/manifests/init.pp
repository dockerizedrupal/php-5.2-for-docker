class php {
  if $ssmtp_port_25_tcp {
    include php::ssmtp
  }

  if $mysqld_port_3306_tcp {
    include php::mysqld
  }
}
