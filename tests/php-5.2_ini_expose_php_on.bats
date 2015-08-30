#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-5.2_ini_expose_php_on.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php-5.2 | grep php-5.2 | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 10
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-5.2: ini: expose_php: on" {
  run docker exec "$(container)" /bin/su - root -lc "php -i | grep 'expose_php'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"On"* ]]
}
