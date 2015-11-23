#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-5.2_drupal_6_drush_5.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup_drupal() {
  docker exec "$(container)" /bin/su - container -lc "wget http://ftp.drupal.org/files/projects/drupal-6.37.tar.gz -O /tmp/drupal-6.37.tar.gz"
  docker exec "$(container)" /bin/su - container -lc "tar xzf /tmp/drupal-6.37.tar.gz -C /tmp"
  docker exec "$(container)" /bin/su - container -lc "rsync -avz /tmp/drupal-6.37/ /apache/data"
  docker exec "$(container)" /bin/su - container -lc "drush -r /apache/data -y site-install --db-url=mysqli://container:container@localhost/drupal --account-name=admin --account-pass=admin"
  docker exec "$(container)" /bin/su - container -lc "chown container.container /apache/data"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 20

  setup_drupal
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-5.2: drupal 6" {
  run docker exec "$(container)" /bin/su - root -mc "drush -r /apache/data/ status | grep 'Drupal bootstrap'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Successful"* ]]
}

@test "php-5.2: drupal 6: drush 5" {
  run docker exec "$(container)" /bin/su - root -mc "drush --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"5.11.0"* ]]
}

@test "php-5.2: drupal 6: phpcs" {
  run docker exec "$(container)" /bin/su - root -mc "phpcs --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"1.5.6"* ]]
}

@test "php-5.2: drupal 6: phpcs: phpcompatibility" {
  run docker exec "$(container)" /bin/su - root -mc "phpcs -i | grep 'PHPCompatibility'"

  [ "${status}" -eq 0 ]
}
