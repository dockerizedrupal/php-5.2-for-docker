class build {
  require build::user

  include build::php52
  include build::php52::extensions
  include build::freetds
  include build::drush
  include build::phpcs
  include build::phpcs::phpcompatibility
  include build::phpcs::coder
  include build::postfix
}
