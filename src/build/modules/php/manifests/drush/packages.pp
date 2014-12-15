class php::drush::packages {
  require php

  exec { '/bin/su - root -c "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename composer"':
    timeout => 0
  }
}
