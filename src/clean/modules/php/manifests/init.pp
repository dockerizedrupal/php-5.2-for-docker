class php {
  exec { 'apt-get clean':
    path => ['/usr/bin']
  }

  exec { 'rm -rf /src/build':
    path => ['/bin']
  }

  exec { 'rm -rf /src/build.sh':
    path => ['/bin']
  }

  exec { 'rm -rf /tmp/*':
    path => ['/bin']
  }

  exec { 'rm -rf /var/lib/apt/lists/*':
    path => ['/bin']
  }
}
