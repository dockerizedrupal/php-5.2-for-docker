docker-php-5.2.17
=================

Run the container
-----------------



Build the image yourself
------------------------

    git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git docker-php
    cd docker-php
    git checkout 5.2.17
    sudo docker build -t php:5.2.17 .

PHP 5.2.17
----------

### Configuration file (php.ini) location

    /opt/phpfarm/inst/php-5.2.17/lib/php.ini

### PHP-FPM (FastCGI Process Manager)

Listening on port 9000

#### Configuration file (php-fpm.conf) location

    /opt/phpfarm/inst/php-5.2.17/etc/php-fpm.conf

### Extensions

#### Xdebug