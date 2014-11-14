node default {
  if $ssmtp_port_25_tcp {
    include ssmtp
  }

  if $mysql_port_3306_tcp {
    include mysql
  }
}
