docker-php
==========

Compiled PHP versions
---------------------

- 5.5.15
- 5.4.31
- 5.3.28
- 5.2.17

Run PHP from the CLI
--------------------

### PHP 5.5.15

    ./php-5.5.15.sh my_script.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src \
      simpledrupalcloud/php \
      php-5.5.15 \
      my_script.php

### PHP 5.4.31

    ./php-5.4.31.sh my_script.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php-5.4.31 \
      my_script.php

### PHP 5.3.28

    ./php-5.3.28.sh my_script.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php-5.3.28 \
      my_script.php

### PHP 5.2.17

    ./php-5.2.17.sh my_script.php

    sudo docker run \
      --rm \
      -i \
      -t \
      -v $(pwd):/src simpledrupalcloud/php \
      php-5.2.17 \
      my_script.php

Run as PHP-FPM (FastCGI Process Manager)
----------------------------------------

    sudo docker run \
      --name php-fpm \
      -p 127.0.0.1:9052:9052 \
      -p 127.0.0.1:9053:9053 \
      -p 127.0.0.1:9054:9054 \
      -p 127.0.0.1:9055:9055 \
      -v /var/www:/var/www \
      -v /etc/apache2/conf.d/fastcgi.conf:/etc/apache2/conf.d/fastcgi.conf \
      -d \
      simpledrupalcloud/php

    sudo docker cp php-fpm:/opt/phpfarm/inst/php-5.2.17/lib/php.ini /opt/data
    sudo docker cp php-fpm:/opt/phpfarm/inst/php-5.3.28/lib/php.ini /opt/data
    sudo docker cp php-fpm:/opt/phpfarm/inst/php-5.4.31/lib/php.ini /opt/data
    sudo docker cp php-fpm:/opt/phpfarm/inst/php-5.5.15/lib/php.ini /opt/data

### Exposed ports

- PHP 5.2 accepting connections on port 9052
- PHP 5.3 accepting connections on port 9053
- PHP 5.4 accepting connections on port 9054
- PHP 5.5 accepting connections on port 9055

### Apache 2.2 FastCGI conf

    /etc/apache/conf.d/fastcgi.conf

Xdebug
------