docker-php-5.2.17
=================

Run the container
-----------------

    sudo docker run \
      --name php5217 \
      --net host \
      --volumes-from apache \
      -d \
      simpledrupalcloud/php:5.2.17

Build the image yourself
------------------------

    git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git docker-php
    cd docker-php
    git checkout 5.2.17
    sudo docker build -t php:5.2.17 .