node default {
  include apt

  apt::source { 'non-free':
    location => 'http://ftp.us.debian.org/debian',
    release => 'stable',
    repos => 'non-free'
  }
}