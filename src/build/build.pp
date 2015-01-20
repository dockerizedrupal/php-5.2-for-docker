node default {
  include php
  include php::extensions
  include php::drush
  include php::phpcs
  include php::phpcs::phpcompatibility
  include php::phpcs::coder
}
