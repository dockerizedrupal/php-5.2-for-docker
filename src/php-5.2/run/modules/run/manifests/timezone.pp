class run::timezone {
  bash_exec { "echo '$timezone' > /etc/timezone": }

  bash_exec { 'dpkg-reconfigure -f noninteractive tzdata':
    require => Bash_exec["echo '$timezone' > /etc/timezone"]
  }
}
