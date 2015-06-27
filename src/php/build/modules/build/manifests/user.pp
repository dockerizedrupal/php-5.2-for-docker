class build::user {
  bash_exec { "groupadd -o -g $(id -g www-data) container": }
  bash_exec { "useradd -m -o -s /bin/bash -u $(id -u www-data) -g $(id -g www-data) container": }
}
