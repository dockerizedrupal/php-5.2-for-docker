# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.2.17 that runs PHP in FPM (FastCGI Process Manager) mode.

## Run the container

Using the `docker` command:

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -d \
      viljaste/php:5.2-dev
      
Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2-dev \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2-dev \
      && sudo docker build -t viljaste/php:5.2-dev . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php /httpd/php
      FastCgiExternalServer /httpd/php -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php
    </IfModule>

## License

**MIT**
