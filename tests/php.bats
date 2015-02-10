#!/usr/bin/env bats

CONTAINER="php"

setup() {
  docker run --name "${CONTAINER}" -h "${CONTAINER}" -p 9000:9000 -d simpledrupalcloud/php:5.2

  sleep 5
}

teardown() {
  docker rm -f "${CONTAINER}"
}

@test "php" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -v"
}

@test "php: xdebug" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'Xdebug'"
}

@test "php: zend opcache" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'Zend OPcache'"
}

@test "php: advanced php debugger (apd)" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'Advanced PHP Debugger (APD)'"
}

@test "php: apcu" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'apcu'"
}

@test "php: memcached" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'memcached'"
}

@test "php: redis" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'redis'"
}

@test "php: igbinary" {
  docker exec "${CONTAINER}" /bin/su - root -mc "php -m | grep 'igbinary'"
}

@test "drush" {
  docker exec "${CONTAINER}" /bin/su - root -mc "drush status"
}
