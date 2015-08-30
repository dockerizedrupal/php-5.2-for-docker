#!/usr/bin/env bats

DOCKER_COMPOSE_FILE="${BATS_TEST_DIRNAME}/php-5.2_drupal_6.yml"

container() {
  echo "$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps php-5.2 | grep php-5.2 | awk '{ print $1 }')"
}

setup_drupal() {
  docker exec "$(container)" /bin/su - root -mc "wget http://ftp.drupal.org/files/projects/drupal-6.37.tar.gz -O /tmp/drupal-6.37.tar.gz"
  docker exec "$(container)" /bin/su - root -mc "tar xzf /tmp/drupal-6.37.tar.gz -C /tmp"
  docker exec "$(container)" /bin/su - root -mc "rsync -avz /tmp/drupal-6.37/ /apache-2.2/data"
  docker exec "$(container)" /bin/su - root -mc "drush -r /apache-2.2/data -y site-install --db-url=mysqli://root:root@localhost/drupal --account-name=admin --account-pass=admin"
  docker exec "$(container)" /bin/su - root -mc "chown container.container /apache-2.2/data"
}

setup() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" up -d

  sleep 10

  setup_drupal
}

teardown() {
  docker-compose -f "${DOCKER_COMPOSE_FILE}" kill
  docker-compose -f "${DOCKER_COMPOSE_FILE}" rm --force
}

@test "php-5.2: drupal 6" {
  run docker exec "$(container)" /bin/su - root -lc "drush -r /apache-2.2/data/ status | grep 'Drupal bootstrap'"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"Successful"* ]]
}

@test "php-5.2: drupal 6: drush 5" {
  run docker exec "$(container)" /bin/su - root -lc "drush --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"5.11.0"* ]]
}

@test "php-5.2: drupal 6: phpcs" {
  run docker exec "$(container)" /bin/su - root -lc "phpcs --version"

  [ "${status}" -eq 0 ]
  [[ "${output}" == *"1.5.6"* ]]
}

@test "php-5.2: drupal 6: phpcs: phpcompatibility" {
  run docker exec "$(container)" /bin/su - root -lc "phpcs -i | grep 'PHPCompatibility'"

  [ "${status}" -eq 0 ]
}
