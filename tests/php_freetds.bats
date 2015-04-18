#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php_freetds.yml"

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

@test "php: freetds: FREETDS_1_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-1'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_1_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-1'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_1_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-1'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_1_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-1'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_2_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-2'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_2_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-2'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_2_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-2'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_2_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-2'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_3_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-3'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_3_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-3'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_3_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-3'"

  [ "${status}" -eq 0 ]
}

@test "php: freetds: FREETDS_3_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-3'"

  [ "${status}" -eq 0 ]
}
