class php {
  if $ssmtp_port_25_tcp {
    include php::ssmtp
  }

  if $mysql_port_3306_tcp {
    include php::mysql
  }
}
