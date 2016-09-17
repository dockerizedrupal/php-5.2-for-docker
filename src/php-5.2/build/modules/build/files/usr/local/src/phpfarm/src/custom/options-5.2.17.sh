configoptions="--with-libdir=/lib/x86_64-linux-gnu \
  --disable-debug \
  --enable-fpm \
  --enable-fastcgi \
  --enable-force-cgi-redirect \
  --enable-gd-native-ttf \
  --enable-exif \
  --enable-ftp \
  --enable-bcmath \
  --enable-sockets \
  --enable-soap \
  --enable-calendar \
  --enable-mbstring \
  --enable-zip \
  --enable-pcntl \
  --with-pgsql \
  --with-pdo-pgsql \
  --with-curl \
  --with-gd \
  --with-jpeg-dir=/usr \
  --with-png-dir=/usr \
  --with-ttf \
  --with-mhash \
  --with-mcrypt \
  --with-mysqli \
  --with-mysql \
  --with-pdo-mysql \
  --with-iconv \
  --with-pear \
  --with-openssl \
  --with-iconv \
  --with-bz2 \
  --with-zlib \
  --with-gettext \
  --with-pspell \
  --with-ldap=/usr \
  --with-config-file-scan-dir=/usr/local/src/phpfarm/inst/php-5.2.17/etc/conf.d \
  --with-mssql=/usr/local/freetds \
  --with-readline \
  --with-freetype-dir \
"

cd $srcdir

cat /src/php-5.2/build/modules/build/files/tmp/debian_patches_disable_SSLv2_for_openssl_1_0_0.patch.patch.txt | patch -p1
cat /src/php-5.2/build/modules/build/files/tmp/txtbgxGXAvz4N.txt | patch -p0
zcat /src/php-5.2/build/modules/build/files/tmp/php-5.2.17-fpm-0.5.14.diff.gz | patch -p1
