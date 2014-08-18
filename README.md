docker-php-fpm
==============

Docker image to run a PHP-FPM

Build the Docker image by yourself
----------------------------------

    $ docker build -t docker-registry.simpledrupalcloud.com/php-fpm http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php-fpm.git

Push the Docker image to private Docker registry
------------------------------------------------

    $ docker push docker-registry.simpledrupalcloud.com/php-fpm

Pull the pre-built Docker image from the private Docker registry
----------------------------------------------------------------

    $ docker pull docker-registry.simpledrupalcloud.com/php-fpm

Run the container
-----------------

    $ docker run --name php-fpm -d docker-registry.simpledrupalcloud.com/php-fpm

Stop the container
------------------

    $ docker stop php-fpm
