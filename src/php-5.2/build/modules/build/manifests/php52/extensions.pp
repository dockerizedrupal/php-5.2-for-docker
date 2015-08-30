class build::php52::extensions {
  require build::php52

  include build::php52::extension::xdebug
  include build::php52::extension::memcached
  include build::php52::extension::redis
  include build::php52::extension::apcu
  include build::php52::extension::zendopcache
  include build::php52::extension::apd
}
