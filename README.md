# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.2 that runs PHP in FPM (FastCGI Process Manager) mode.

## Run the container

Using the `docker` command:

    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      -d \
      viljaste/php:5.2
      
Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2 \
      && sudo docker build -t viljaste/php:5.2 . \
      && cd -

## License

**MIT**
