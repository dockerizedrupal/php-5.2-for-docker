class build::php::extensions {
  require build::php

  include build::php::extension::xdebug
  include build::php::extension::memcached
  include build::php::extension::redis
  include build::php::extension::apcu
  include build::php::extension::zendopcache
  include build::php::extension::apd
}
