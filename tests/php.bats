#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d --allow-insecure-ssl

  sleep 10
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php" {
  run docker exec "$(container)" /bin/su - root -mc "php -v"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"PHP 5.2"* ]]
}

@test "php: extension: igbinary" {
  run docker exec "$(container)" /bin/su - root -mc "php -m | grep 'igbinary'"

  [ "${status}" -eq 0 ]
}

@test "php: extension: mssql" {
  run docker exec "$(container)" /bin/su - root -mc "php -m | grep 'mssql'"

  [ "${status}" -eq 0 ]
}

@test "php: smtp: disabled" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/postfix/main.cf | grep 'relayhost'"

  [ "${status}" -ne 0 ]
}
