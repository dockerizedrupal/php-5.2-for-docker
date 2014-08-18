configoptions="--with-libdir=/lib/x86_64-linux-gnu \
  --enable-fpm \
  --enable-force-cgi-redirect \
  --enable-gd-native-ttf \
  --enable-exif \
  --enable-ftp \
  --enable-bcmath \
  --enable-sockets \
  --enable-soap \
  --enable-calendar \
  --enable-mbstring \
  --with-fpm-user=www-data \
  --with-fpm-group=www-data \
  --with-bz2 \
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
  --with-zlib \
  --with-gettext \
  --with-pspell \
"

cd $srcdir

# https://bugs.php.net/bug.php?id=54736
wget 'https://bugs.php.net/patch-display.php?bug_id=54736&patch=debian_patches_disable_SSLv2_for_openssl_1_0_0.patch&revision=1305414559&download=1' -O /tmp/debian_patches_disable_SSLv2_for_openssl_1_0_0.patch

patch -p1 < /tmp/debian_patches_disable_SSLv2_for_openssl_1_0_0.patch

# http://www.litespeedtech.com/support/forum/threads/solved-compile-php-5-2.6887/
wget 'https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt' -O /tmp/php-5.4.5-libxm2-2.9.0.patch

patch -p0 < /tmp/php-5.4.5-libxm2-2.9.0.patch