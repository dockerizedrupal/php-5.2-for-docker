docker-php-5.2.17
=================

Run the container
-----------------

    CONTAINER=php5217 && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 5217:5217
      -v /var/www:/var/www \
      -d \
      simpledrupalcloud/php:5.2.17

Build the image
---------------

    TMP=$(mktemp -d) \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2.17 \
      && sudo docker build -t simpledrupalcloud/php:5.2.17 . \
      && cd -