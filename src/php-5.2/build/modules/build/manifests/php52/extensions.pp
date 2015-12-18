class build::php52::extensions {
  require build::php52

  include build::php52::extensions::xdebug
  include build::php52::extensions::memcached
  include build::php52::extensions::redis
  include build::php52::extensions::apcu
  include build::php52::extensions::zendopcache
  include build::php52::extensions::apd
}
