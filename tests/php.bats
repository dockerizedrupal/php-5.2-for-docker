#!/usr/bin/env bats

@test "php" {
  docker exec -i -t php /bin/su - root -mc "php -v"
}

@test "php: xdebug" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'Xdebug'"
}

@test "php: zend opcache" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'Zend OPcache'"
}

@test "php: advanced php debugger (apd)" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'Advanced PHP Debugger (APD)'"
}

@test "php: apcu" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'apcu'"
}

@test "php: memcached" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'memcached'"
}

@test "php: redis" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'redis'"
}

@test "php: igbinary" {
  docker exec -i -t php /bin/su - root -mc "php -m | grep 'igbinary'"
}

@test "drush" {
  docker exec -i -t php /bin/su - root -mc "drush status"
}
