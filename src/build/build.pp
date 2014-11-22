node default {
  include php
  include php::extension::xdebug
  include php::extension::memcached
  include php::extension::redis
}
