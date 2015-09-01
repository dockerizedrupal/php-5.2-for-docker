# docker-php-5.2

A [Docker](https://docker.com/) image for [PHP](http://php.net/) version 5.2 that runs PHP in FPM (FastCGI Process Manager) mode.

Configuration, PHP extensions and other tools built into the image are primarily aimed for the developers that are using [Drupal](https://www.drupal.org/) as their primary development framework.

## Run the container

Using the `docker` command:

    CONTAINER="php-5.2" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -e SERVER_NAME="localhost" \
      -e DRUPAL_VERSION="6" \
      -e PHP_INI_REALPATH_CACHE_SIZE="256k" \
      -e PHP_INI_REALPATH_CACHE_TTL="3600" \
      -e PHP_INI_POST_MAX_SIZE="512M" \
      -e PHP_INI_TIMEZONE="UTC" \
      -e PHP_INI_UPLOAD_MAX_FILESIZE="512M" \
      -e PHP_INI_SHORT_OPEN_TAG="On" \
      -e PHP_INI_MAX_EXECUTION_TIME="300" \
      -e PHP_INI_MAX_INPUT_VARS="4096" \
      -e PHP_INI_MEMORY_LIMIT="512M" \
      -e PHP_INI_DISPLAY_ERRORS="On" \
      -e PHP_INI_DISPLAY_STARTUP_ERRORS="On" \
      -e PHP_INI_ERROR_REPORTING="E_ALL" \
      -e PHP_INI_EXPOSE_PHP="On" \
      -e PHP_INI_ALLOW_URL_FOPEN="On" \
      -e PHP_INI_OPCACHE="On" \
      -e PHP_INI_OPCACHE_MEMORY_CONSUMPTION="2048" \
      -e PHP_INI_XDEBUG="On" \
      -e PHP_INI_XDEBUG_REMOTE_PORT="9000" \
      -e PHP_INI_XDEBUG_REMOTE_HOST="127.0.0.1" \
      -e PHP_INI_XDEBUG_REMOTE_CONNECT_BACK="On" \
      -e PHP_INI_XDEBUG_IDEKEY="PHPSTORM" \
      -e PHP_INI_MEMCACHED="On" \
      -e PHP_INI_REDIS="On" \
      -e PHP_INI_APCU="On" \
      -e PHP_INI_APD="On" \
      -e PHP_FPM_PM="static" \
      -e PHP_FPM_PM_MAX_CHILDREN="5" \
      -e PHP_FPM_PM_START_SERVERS="20" \
      -e PHP_FPM_PM_MIN_SPARE_SERVERS="5" \
      -e PHP_FPM_PM_MAX_SPARE_SERVERS="35" \
      -e PHP_FPM_PM_MAX_REQUESTS="500" \
      -e USER_ID="" \
      -e GROUP_ID="" \
      -d \
      dockerizedrupal/php-5.2:latest
      
Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-php-5.2.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone https://github.com/dockerizedrupal/docker-php-5.2.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t dockerizedrupal/php-5.2:latest . \
      && cd -

## Tests

Tests are implemented in [Bats: Bash Automated Testing System](https://github.com/sstephenson/bats).

### Test results for the current release

    1..68
    ok 1 php-5.2
    ok 2 php-5.2: drupal 6
    ok 3 php-5.2: drupal 6: drush 5
    ok 4 php-5.2: drupal 6: phpcs
    ok 5 php-5.2: drupal 6: phpcs: phpcompatibility
    ok 6 php: drupal 7
    ok 7 php: drupal 7: drush 5
    ok 8 php: drupal 7: phpcs
    ok 9 php: drupal 7: phpcs: phpcompatibility
    ok 10 php-5.2: fpm: pm
    ok 11 php-5.2: fpm: pm.max_children
    ok 12 php-5.2: fpm: pm.max_requests
    ok 13 php-5.2: fpm: pm.max_spare_servers
    ok 14 php-5.2: fpm: pm.min_spare_servers
    ok 15 php-5.2: fpm: pm.start_servers
    ok 16 php-5.2: freetds: FREETDS_1_SERVER_NAME
    ok 17 php-5.2: freetds: FREETDS_1_HOST
    ok 18 php-5.2: freetds: FREETDS_1_PORT
    ok 19 php-5.2: freetds: FREETDS_1_TDS_VERSION
    ok 20 php-5.2: freetds: FREETDS_2_SERVER_NAME
    ok 21 php-5.2: freetds: FREETDS_2_HOST
    ok 22 php-5.2: freetds: FREETDS_2_PORT
    ok 23 php-5.2: freetds: FREETDS_2_TDS_VERSION
    ok 24 php-5.2: freetds: FREETDS_3_SERVER_NAME
    ok 25 php-5.2: freetds: FREETDS_3_HOST
    ok 26 php-5.2: freetds: FREETDS_3_PORT
    ok 27 php-5.2: freetds: FREETDS_3_TDS_VERSION
    ok 28 php-5.2: ini: allow_url_fopen: off
    ok 29 php-5.2: ini: allow_url_fopen: on
    ok 30 php-5.2: ini: apcu: off
    ok 31 php-5.2: ini: apcu: on
    ok 32 php-5.2: ini: apd: off
    ok 33 php-5.2: ini: apd: on
    ok 34 php-5.2: ini: display_errors: off
    ok 35 php-5.2: ini: display_errors: on
    ok 36 php-5.2: ini: display_startup_errors: off
    ok 37 php-5.2: ini: display_startup_errors: on
    ok 38 php-5.2: ini: error_reporting
    ok 39 php-5.2: ini: expose_php: off
    ok 40 php-5.2: ini: expose_php: on
    ok 41 php-5.2: ini: igbinary: on
    ok 42 php-5.2: ini: max_execution_time
    ok 43 php-5.2: ini: max_input_vars
    ok 44 php-5.2: ini: memcached: off
    ok 45 php-5.2: ini: memcached: on
    ok 46 php-5.2: ini: memory_limit
    ok 47 php-5.2: ini: mssql: on
    ok 48 php-5.2: ini: opcache.memory_consumption
    ok 49 php-5.2: ini: opcache: off
    ok 50 php-5.2: ini: opcache: on
    ok 51 php-5.2: ini: post_max_size
    ok 52 php-5.2: ini: realpath_cache_size
    ok 53 php-5.2: ini: realpath_cache_ttl
    ok 54 php-5.2: ini: redis: off
    ok 55 php-5.2: ini: redis: on
    ok 56 php-5.2: ini: short_open_tag: off
    ok 57 php-5.2: ini: short_open_tag: on
    ok 58 php-5.2: ini: timezone
    ok 59 php-5.2: ini: upload_max_filesize
    ok 60 php-5.2: ini: xdebug.idekey
    ok 61 php-5.2: ini: xdebug: off
    ok 62 php-5.2: ini: xdebug: on
    ok 63 php-5.2: ini: xdebug.remote_connect_back: off
    ok 64 php-5.2: ini: xdebug.remote_connect_back: on
    ok 65 php-5.2: ini: xdebug.remote_host
    ok 66 php-5.2: ini: xdebug.remote_port
    ok 67 php-5.2: smtp: off
    ok 68 php-5.2: smtp: on

## License

**MIT**
