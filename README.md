# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.2.17 that runs PHP in FPM (FastCGI Process Manager) mode.

## PHP 5.2.17 (STABLE BRANCH)

### Run the container

Using the `docker` command:

    CONTAINER="data" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /var/www:/var/www \
      simpledrupalcloud/data:latest

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      --volumes-from data \
      -d \
      simpledrupalcloud/php:5.2
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo fig up

### Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo docker build -t simpledrupalcloud/php:5.2 . \
      && cd -

### Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php /var/www/php
      FastCgiExternalServer /var/www/php -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php
    </IfModule>

## License

**MIT**
