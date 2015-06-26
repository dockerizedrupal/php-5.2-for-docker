class clean {
  bash_exec { 'apt-get clean': }

  bash_exec { 'rm -rf /tmp/*': }

  bash_exec { 'rm -rf /var/lib/apt/lists/*': }
}
