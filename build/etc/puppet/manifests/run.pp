node default {
  if $ssmtp_port_25_tcp {
    include ssmtp
  }
}
