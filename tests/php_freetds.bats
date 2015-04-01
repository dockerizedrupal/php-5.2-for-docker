#!/usr/bin/env bats

FIG_FILE="${BATS_TEST_DIRNAME}/php_freetds.yml"

container() {
  echo "$(fig -f ${FIG_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  fig -f "${FIG_FILE}" up -d --allow-insecure-ssl

  sleep 10
}

teardown() {
  fig -f "${FIG_FILE}" kill
  fig -f "${FIG_FILE}" rm --force
}

@test "php: freetds: FREETDS_1_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-1'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_1_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-1'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_1_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-1'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_1_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-1'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_2_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-2'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_2_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-2'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_2_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-2'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_2_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-2'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_3_SERVER_NAME" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'server-name-3'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_3_HOST" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'host-3'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_3_PORT" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'port-3'"

  [ "${status}" -ne 0 ]
}

@test "php: freetds: FREETDS_3_TDS_VERSION" {
  run docker exec "$(container)" /bin/su - root -mc "cat /usr/local/freetds/etc/freetds.conf | grep 'tds-version-3'"

  [ "${status}" -ne 0 ]
}
