docker-php
==========

Compiled PHP versions
---------------------

- 5.2.17
- 5.3.28
- 5.4.31
- 5.5.15

Run PHP from the command line
-----------------------------

### PHP 5.2

    ./php.sh php52 index.php
    ./php52.sh index.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php52 \
      index.php


### PHP 5.3

    ./php.sh php53 index.php
    ./php53.sh index.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php53 \
      index.php

### PHP 5.4

    ./php.sh php54 index.php
    ./php54.sh index.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php54 \
      index.php

### PHP 5.5

    ./php.sh php55 index.php
    ./php55.sh index.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src \
      simpledrupalcloud/php \
      php55 \
      index.php

Run as PHP-FPM (FastCGI Process Manager)
----------------------------------------

    sudo docker run \
      --name php-fpm \
      -p 127.0.0.1:9052:9052 \
      -p 127.0.0.1:9053:9053 \
      -p 127.0.0.1:9054:9054 \
      -p 127.0.0.1:9055:9055 \
      -v /var/www:/var/www \
      -v /etc/apache/conf.d/fastcgi.conf:/etc/apache/conf.d/fastcgi.conf \
      -d \
      simpledrupalcloud/php

### Exposed ports

- PHP 5.2 accepting connections on port 9052
- PHP 5.3 accepting connections on port 9053
- PHP 5.4 accepting connections on port 9054
- PHP 5.5 accepting connections on port 9055

### Apache 2.2 FastCGI conf

    /etc/apache/conf.d/fastcgi.conf