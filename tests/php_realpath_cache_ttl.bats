#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php_realpath_cache_ttl.yml"

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

@test "php: realpath_cache_ttl" {
  run docker exec "$(container)" /bin/su - root -mc "php -i | grep 'realpath_cache_ttl'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"7200"* ]]
}
