node default {
  class { '::apt':
    always_apt_update => true,
  }

  package {[
      'git',
      'build-essential',
      'libxml2-dev',
      'libssl-dev',
      'libbz2-dev',
      'libcurl4-gnutls-dev',
      'libpng12-dev',
      'libmcrypt-dev',
      'libmhash-dev',
      'libmysqlclient-dev',
      'libpspell-dev'
    ]:
    ensure  => 'installed'
  }

  apt::source { 'non-free':
    location => 'http://ftp.us.debian.org/debian',
    release => 'stable',
    repos => 'non-free'
  }
}