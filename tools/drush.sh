#!/usr/bin/env bash

WORKING_DIR="$(pwd)"

hash docker 2> /dev/null

if [ "${?}" -ne 0 ]; then
  echo "drush: docker command not found."

  exit 1
fi

hash docker-compose 2> /dev/null

if [ "${?}" -ne 0 ]; then
  echo "drush: docker-compose command not found."

  exit 1
fi

DRUPAL_ROOT_DIRECTORY="/httpd/data"

ARGS="${@}"

php_container_exists() {
  local DRUPAL_ROOT="${1}"

  echo "$(cd ${DRUPAL_ROOT} && docker-compose ps php 2> /dev/null | grep _php_ | awk '{ print $1 }')"
}

php_container_running() {
  local CONTAINER="${1}"

  echo "$(docker exec ${CONTAINER} date 2> /dev/null)"
}

docker_compose_file_path() {
  local DOCKER_COMPOSE_FILE_PATH=""

  while [ "$(pwd)" != '/' ]; do
    if [ "$(ls docker-compose.yml 2> /dev/null)" = "docker-compose.yml" ]; then
      DOCKER_COMPOSE_FILE_PATH="$(pwd)"

      break
    fi

    cd ..
  done

  echo "${DOCKER_COMPOSE_FILE_PATH}"
}

fig_file_path() {
  local FIG_FILE_PATH=""

  while [ "$(pwd)" != '/' ]; do
    if [ "$(ls fig.yml 2> /dev/null)" = "fig.yml" ]; then
      FIG_FILE_PATH="$(pwd)"

      break
    fi

    cd ..
  done

  echo "${FIG_FILE_PATH}"
}

drupal_8_docker_compose_template() {
  local PROJECT_NAME="${1}"

  cat <<EOF
httpd:
  image: viljaste/httpd:latest
  hostname: httpd
  ports:
    - "80"
    - "443"
  volumes_from:
    - httpdata
  links:
    - php
  environment:
    - VHOST=${PROJECT_NAME}
httpdata:
  image: viljaste/data:latest
  hostname: httpdata
  volumes:
    - .:/httpd/data
mysqld:
  image: viljaste/mysqld:latest
  hostname: mysqld
  volumes_from:
    - mysqlddata
mysqlddata:
  image: viljaste/data:latest
  hostname: mysqlddata
  volumes:
    - /mysqld
php:
  image: viljaste/php:5.4
  hostname: php
  volumes:
    - ~/.ssh:/root/.ssh
  volumes_from:
    - httpdata
  links:
    - mysqld
    - mailcatcher:smtp
    - memcached
  environment:
    - DRUPAL_VERSION=8
mailcatcher:
  image: viljaste/mailcatcher:latest
  hostname: mailcatcher
  ports:
    - "80"
  environment:
    - VHOST=${PROJECT_NAME}
phpmyadmin:
  image: viljaste/phpmyadmin:latest
  hostname: phpmyadmin
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
adminer:
  image: viljaste/adminer:latest
  hostname: adminer
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
memcached:
  image: viljaste/memcached:latest
  hostname: memcached
  environment:
    - CACHESIZE=512
    - MAX_ITEM_SIZE=16m
    - VERBOSITY=vvv
memcachephp:
  image: viljaste/memcachephp:latest
  hostname: memcachephp
  ports:
    - "80"
    - "443"
  links:
    - memcached
  environment:
    - VHOST=${PROJECT_NAME}
EOF
}

drupal_8_path() {
  local DRUPAL_8_PATH=""

  while [ "$(pwd)" != '/' ]; do
    if [ "$(ls index.php 2> /dev/null)" == "index.php" ]; then
      if [ -n "$(cat index.php | grep "^\$autoloader" 2> /dev/null)" ]; then
        DRUPAL_8_PATH="$(pwd)"

        break
      fi
    fi

    cd ..
  done

  echo "${DRUPAL_8_PATH}"
}

drupal_7_docker_compose_template() {
  local PROJECT_NAME="${1}"

  cat <<EOF
httpd:
  image: viljaste/httpd:latest
  hostname: httpd
  ports:
    - "80"
    - "443"
  volumes_from:
    - httpdata
  links:
    - php
  environment:
    - VHOST=${PROJECT_NAME}
httpdata:
  image: viljaste/data:latest
  hostname: httpdata
  volumes:
    - .:/httpd/data
mysqld:
  image: viljaste/mysqld:latest
  hostname: mysqld
  volumes_from:
    - mysqlddata
mysqlddata:
  image: viljaste/data:latest
  hostname: mysqlddata
  volumes:
    - /mysqld
php:
  image: viljaste/php:5.3
  hostname: php
  volumes:
    - ~/.ssh:/root/.ssh
  volumes_from:
    - httpdata
  links:
    - mysqld
    - mailcatcher:smtp
    - memcached
  environment:
    - DRUPAL_VERSION=7
mailcatcher:
  image: viljaste/mailcatcher:latest
  hostname: mailcatcher
  ports:
    - "80"
  environment:
    - VHOST=${PROJECT_NAME}
phpmyadmin:
  image: viljaste/phpmyadmin:latest
  hostname: phpmyadmin
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
adminer:
  image: viljaste/adminer:latest
  hostname: adminer
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
memcached:
  image: viljaste/memcached:latest
  hostname: memcached
  environment:
    - CACHESIZE=512
    - MAX_ITEM_SIZE=16m
    - VERBOSITY=vvv
memcachephp:
  image: viljaste/memcachephp:latest
  hostname: memcachephp
  ports:
    - "80"
    - "443"
  links:
    - memcached
  environment:
    - VHOST=${PROJECT_NAME}
EOF
}

drupal_7_path() {
  local DRUPAL_7_PATH=""

  while [ "$(pwd)" != '/' ]; do
    if [ "$(ls index.php 2> /dev/null)" == "index.php" ]; then
      if [ -n "$(cat index.php | grep "^menu_execute_active_handler" 2> /dev/null)" ]; then
        DRUPAL_7_PATH="$(pwd)"

        break
      fi
    fi

    cd ..
  done

  echo "${DRUPAL_7_PATH}"
}

drupal_6_docker_compose_template() {
  local PROJECT_NAME="${1}"

  cat <<EOF
httpd:
  image: viljaste/httpd:latest
  hostname: httpd
  ports:
    - "80"
    - "443"
  volumes_from:
    - httpdata
  links:
    - php
  environment:
    - VHOST=${PROJECT_NAME}
httpdata:
  image: viljaste/data:latest
  hostname: httpdata
  volumes:
    - .:/httpd/data
mysqld:
  image: viljaste/mysqld:latest
  hostname: mysqld
  volumes_from:
    - mysqlddata
mysqlddata:
  image: viljaste/data:latest
  hostname: mysqlddata
  volumes:
    - /mysqld
php:
  image: viljaste/php:5.2
  hostname: php
  volumes:
    - ~/.ssh:/root/.ssh
  volumes_from:
    - httpdata
  links:
    - mysqld
    - mailcatcher:smtp
    - memcached
  environment:
    - DRUPAL_VERSION=6
mailcatcher:
  image: viljaste/mailcatcher:latest
  hostname: mailcatcher
  ports:
    - "80"
  environment:
    - VHOST=${PROJECT_NAME}
phpmyadmin:
  image: viljaste/phpmyadmin:latest
  hostname: phpmyadmin
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
adminer:
  image: viljaste/adminer:latest
  hostname: adminer
  ports:
    - "80"
    - "443"
  links:
    - mysqld
  environment:
    - VHOST=${PROJECT_NAME}
memcached:
  image: viljaste/memcached:latest
  hostname: memcached
  environment:
    - CACHESIZE=512
    - MAX_ITEM_SIZE=16m
    - VERBOSITY=vvv
memcachephp:
  image: viljaste/memcachephp:latest
  hostname: memcachephp
  ports:
    - "80"
    - "443"
  links:
    - memcached
  environment:
    - VHOST=${PROJECT_NAME}
EOF
}

drupal_6_path() {
  local DRUPAL_6_PATH=""

  while [ "$(pwd)" != '/' ]; do
    if [ "$(ls index.php 2> /dev/null)" == "index.php" ]; then
      if [ -n "$(cat index.php | grep "^drupal_page_footer" 2> /dev/null)" ]; then
        DRUPAL_6_PATH="$(pwd)"

        break
      fi
    fi

    cd ..
  done

  echo "${DRUPAL_6_PATH}"
}

DRUPAL_ROOT="$(fig_file_path)"

if [ -n "${DRUPAL_ROOT}" ]; then
  read -p "Fig is now deprecated and will be replaced with Docker Compose, would you like to rename fig.yml to docker-compose.yml? [Y/n]: " ANSWER

  if [ "${ANSWER}" == "n" ]; then
    exit
  fi

  mv "${DRUPAL_ROOT}/fig.yml" "${DRUPAL_ROOT}/docker-compose.yml"
fi

DRUPAL_ROOT="$(docker_compose_file_path)"

if [ -n "${DRUPAL_ROOT}" ]; then
  STATUS=$(cat "${DRUPAL_ROOT}/docker-compose.yml" | grep 'simpledrupalcloud' > /dev/null 2>&1 || echo "${?}")

  if [[ "${STATUS}" -eq 0 ]]; then
    read -p "The contents of Docker Compose file is outdated. Would you like to generate a new Docker Compose file? [Y/n]: " ANSWER

    if [ "${ANSWER}" == "n" ]; then
      exit
    fi

    rm -f "${DRUPAL_ROOT}/docker-compose.yml"
  fi
fi

DRUPAL_ROOT="$(docker_compose_file_path)"

if [ -n "${DRUPAL_ROOT}" ]; then
  STATUS=$(cat "${DRUPAL_ROOT}/docker-compose.yml" | grep 'simpledrupalcloud' > /dev/null 2>&1 || echo "${?}")

  if [[ "${STATUS}" -eq 0 ]]; then
    read -p "The contents of Docker Compose file is outdated. Would you like to generate a new Docker Compose file? [Y/n]: " ANSWER

    if [ "${ANSWER}" == "n" ]; then
      exit
    fi

    rm -f "${DRUPAL_ROOT}/docker-compose.yml"
  fi
fi

DRUPAL_ROOT="$(docker_compose_file_path)"

if [ -n "${DRUPAL_ROOT}" ]; then
  STATUS=$(cat "${DRUPAL_ROOT}/docker-compose.yml" | grep '/mysqld/data' > /dev/null 2>&1 || echo "${?}")

  if [[ "${STATUS}" -eq 0 ]]; then
    read -p "The contents of Docker Compose file is outdated. Would you like to generate a new Docker Compose file? [Y/n]: " ANSWER

    if [ "${ANSWER}" == "n" ]; then
      exit
    fi

    rm -f "${DRUPAL_ROOT}/docker-compose.yml"
  fi
fi

DRUPAL_ROOT="$(docker_compose_file_path)"

if [ -n "${DRUPAL_ROOT}" ]; then
  STATUS=$(cat "${DRUPAL_ROOT}/docker-compose.yml" | grep 'DRUSH_VERSION' > /dev/null 2>&1 || echo "${?}")

  if [[ "${STATUS}" -eq 0 ]]; then
    read -p "The contents of Docker Compose file is outdated. Would you like to generate a new Docker Compose file? [Y/n]: " ANSWER

    if [ "${ANSWER}" == "n" ]; then
      exit
    fi

    rm -f "${DRUPAL_ROOT}/docker-compose.yml"
  fi
fi

DRUPAL_ROOT="$(docker_compose_file_path)"

if [ -z "${DRUPAL_ROOT}" ]; then
  DRUPAL_ROOT="$(drupal_8_path)"

  if [ -n "${DRUPAL_ROOT}" ]; then
    read -p "Enter project name: " PROJECT_NAME

    echo -n "$(drupal_8_docker_compose_template ${PROJECT_NAME})" > "${DRUPAL_ROOT}/docker-compose.yml"

    chown -R "${SUDO_USER}".www-data "${DRUPAL_ROOT}/docker-compose.yml"
  else
    DRUPAL_ROOT="$(drupal_7_path)"

    if [ -n "${DRUPAL_ROOT}" ]; then
      read -p "Enter project name: " PROJECT_NAME

      echo -n "$(drupal_7_docker_compose_template ${PROJECT_NAME})" > "${DRUPAL_ROOT}/docker-compose.yml"

      chown -R "${SUDO_USER}".www-data "${DRUPAL_ROOT}/docker-compose.yml"
    else
      DRUPAL_ROOT="$(drupal_6_path)"

      if [ -n "${DRUPAL_ROOT}" ]; then
        read -p "Enter project name: " PROJECT_NAME

        echo -n "$(drupal_6_docker_compose_template ${PROJECT_NAME})" > "${DRUPAL_ROOT}/docker-compose.yml"

        chown -R "${SUDO_USER}".www-data "${DRUPAL_ROOT}/docker-compose.yml"
      else
        echo "Drupal installation path could not be found."

        exit 1
      fi
    fi
  fi
fi

CONTAINER="$(php_container_exists ${DRUPAL_ROOT})"

if [ -z "${CONTAINER}" ]; then
  read -p "PHP container could not be found. Would you like to start the containers? [Y/n]: " ANSWER

  if [ "${ANSWER}" == "n" ]; then
    exit
  fi

  cd "${DRUPAL_ROOT}"

  docker-compose up -d

  cd "${WORKING_DIR}"

  CONTAINER="$(php_container_exists ${DRUPAL_ROOT})"
elif [ -z "$(php_container_running ${CONTAINER})" ]; then
  read -p "PHP container is not running. Would you like to start the containers? [Y/n]: " ANSWER

  if [ "${ANSWER}" == "n" ]; then
    exit
  fi

  cd "${DRUPAL_ROOT}"

  docker-compose up -d

  cd "${WORKING_DIR}"
fi

RELATIVE_PATH="${WORKING_DIR/${DRUPAL_ROOT}}"

if [ "${RELATIVE_PATH:0:1}" == '/' ]; then
  RELATIVE_PATH="$(echo "${RELATIVE_PATH}" | cut -c 2-)"
fi

DRUPAL_WORKING_DIRECTORY="${DRUPAL_ROOT_DIRECTORY}/${RELATIVE_PATH}"

if [ -t 0 ]; then
  docker exec -i -t "${CONTAINER}" /bin/bash -lc "cd ${DRUPAL_WORKING_DIRECTORY} && drush ${ARGS}"
else
  docker exec -i "${CONTAINER}" /bin/bash -lc "cd ${DRUPAL_WORKING_DIRECTORY} && drush ${ARGS}"
fi

chown -R "${SUDO_USER}".www-data "${DRUPAL_ROOT}"
chmod -R u+w "${DRUPAL_ROOT}"
