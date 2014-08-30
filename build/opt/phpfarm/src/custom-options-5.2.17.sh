configoptions="--with-libdir=/lib/x86_64-linux-gnu \
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
  --with-fpm-user=www-data \
  --with-fpm-group=www-data \
  --with-curl \
  --with-gd \
  --with-jpeg \
  --with-png \
  --with-ttf \
  --with-mhash \
  --with-mcrypt \
  --with-mysqli \
  --with-mysql \
  --with-pdo-mysql \
  --with-libxml \
  --with-mbstring \
  --with-iconv \
  --with-pear \
  --with-openssl \
  --with-iconv \
  --with-bz2 \
  --with-zlib \
  --with-gettext \
  --with-pspell \
"

cd $srcdir

curl -sS 'https://bugs.php.net/patch-display.php?bug_id=54736&patch=debian_patches_disable_SSLv2_for_openssl_1_0_0.patch&revision=1305414559&download=1' | patch -p1
curl -sS https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt | patch -p0
curl -sS http://php-fpm.org/downloads/php-5.2.17-fpm-0.5.14.diff.gz | gunzip | patch -p1
