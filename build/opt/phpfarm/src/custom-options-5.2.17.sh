configoptions="--with-libdir=/lib/x86_64-linux-gnu \
  --enable-shared \
  --enable-apc=shared \
  --enable-memcached=shared \
  --enable-xdebug=shared \
  --enable-fpm \
  --enable-fastcgi \
  --enable-force-cgi-redirect \
  --enable-gd-native-ttf \
  --enable-exif=shared \
  --enable-ftp=shared \
  --enable-bcmath=shared \
  --enable-sockets=shared \
  --enable-soap=shared \
  --enable-calendar=shared \
  --enable-mbstring \
  --enable-zip=shared \
  --with-fpm-user=www-data \
  --with-fpm-group=www-data \
  --with-curl=shared \
  --with-gd=shared \
  --with-jpeg \
  --with-png \
  --with-ttf \
  --with-mhash \
  --with-mcrypt=shared \
  --with-mysqli=shared \
  --with-mysql=shared \
  --with-pdo-mysql=shared \
  --with-libxml \
  --with-mbstring \
  --with-iconv=shared \
  --with-pear \
  --with-openssl=shared \
  --with-iconv=shared \
  --with-bz2=shared \
  --with-zlib \
  --with-gettext=shared \
  --with-pspell=shared \
"

cd $srcdir

curl -sS 'https://bugs.php.net/patch-display.php?bug_id=54736&patch=debian_patches_disable_SSLv2_for_openssl_1_0_0.patch&revision=1305414559&download=1' | patch -p1
curl -sS https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt | patch -p0
curl -sS http://php-fpm.org/downloads/php-5.2.17-fpm-0.5.14.diff.gz | gunzip | patch -p1
