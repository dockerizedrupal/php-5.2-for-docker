#!/usr/bin/env bats

YAML_FILE="${BATS_TEST_DIRNAME}/drush.yml"

container() {
  echo "$(fig -f ${YAML_FILE} ps php | grep php | awk '{ print $1 }')"
}

setup() {
  fig -f "${YAML_FILE}" up -d

  sleep 5

  docker exec "$(container)" /bin/su - root -mc "cd /httpd/data && wget http://ftp.drupal.org/files/projects/drupal-6.34.tar.gz"
  docker exec "$(container)" /bin/su - root -mc "cd /httpd/data && tar xzf drupal-6.34.tar.gz"
  docker exec "$(container)" /bin/su - root -mc "cd /httpd/data && chown www-data-www.data drupal-6.34"
  docker exec "$(container)" /bin/su - root -mc "cd /httpd/data/drupal-6.34 && drush -y site-install --db-url=mysql://root:root@localhost/drupal --account-name=admin --account-pass=admin"
}

teardown() {
  fig -f "${YAML_FILE}" kill
  fig -f "${YAML_FILE}" rm --force
}

@test "drush" {
  docker exec "$(container)" /bin/su - root -mc "drush status"
}
