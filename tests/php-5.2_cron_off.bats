#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-5.2_cron_off.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 20
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-5.2: cron: off" {
  run docker exec "$(container)" /bin/su - root -mc "[ -f /etc/supervisor/conf.d/cron.conf ]"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_1_MAILTO: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_1 | grep 'mailto-1'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_1_EXPRESSION: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_1 | grep 'expression-1'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_1_COMMAND: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_1 | grep 'command-1'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_2_MAILTO: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_2 | grep 'mailto-2'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_2_EXPRESSION: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_2 | grep 'expression-2'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_2_COMMAND: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_2 | grep 'command-2'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_3_MAILTO: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_3 | grep 'mailto-3'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_3_EXPRESSION: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_3 | grep 'expression-3'"

  [ "${status}" -ne 0 ]
}

@test "php-5.2: cron: CRONTAB_3_COMMAND: off" {
  run docker exec "$(container)" /bin/su - root -mc "cat /etc/cron.d/crontab_3 | grep 'command-3'"

  [ "${status}" -ne 0 ]
}
