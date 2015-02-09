# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.2.17 that runs PHP in FPM (FastCGI Process Manager) mode.

## Run the container

Using the `docker` command:

    CONTAINER="php52" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -d \
      simpledrupalcloud/php:5.2
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo docker build -t simpledrupalcloud/php:5.2 . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php52 /httpd/php52
      FastCgiExternalServer /httpd/php52 -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php52>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php52
    </IfModule>

## License

**MIT**
