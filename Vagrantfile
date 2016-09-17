VERSION = "2.0.0"

required_plugins = %w(vagrant-vbguest)

required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

MEMORY_SIZE = 512

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = "php"

  config.vm.provider "virtualbox" do |v|
    name = "dockerizedrupal-php-5.2-for-docker-" + VERSION

    name.gsub!(".", "-")

    v.name = name
    v.memory = MEMORY_SIZE
  end

  config.vm.provision "shell", inline: "initctl emit vagrant-ready", run: "always"

  config.vm.provision "shell" do |s|
    s.inline = <<-SHELL
      MEMORY_SIZE="${1}"

      swap_create() {
        local memory_size="${1}"
        local swap_size=$((${memory_size}*2))

        swapoff -a

        fallocate -l "${swap_size}m" /swapfile

        chmod 600 /swapfile

        mkswap /swapfile
        swapon /swapfile

        echo "/swapfile none swap sw 0 0" >> /etc/fstab

        sysctl vm.swappiness=10
        echo "vm.swappiness=10" >> /etc/sysctl.conf

        sysctl vm.vfs_cache_pressure=50
        echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
      }

      docker_engine_install() {
        wget -qO- https://get.docker.com/ | sh

        sed -i "s/^start on (local-filesystems and net-device-up IFACE!=lo)/start on vagrant-ready/" /etc/init/docker.conf

        usermod -aG docker vagrant
      }

      docker_compose_install() {
        curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose

        chmod +x /usr/local/bin/docker-compose
      }

      nodejs_install() {
        curl -sL https://deb.nodesource.com/setup_4.x | bash -

        apt-get install -y nodejs
      }

      grunt_install() {
        npm install -g grunt-cli
      }

      bats_install() {
        local tmp="$(mktemp -d)"

        git clone https://github.com/sstephenson/bats.git "${tmp}"

        cd "${tmp}"

        ./install.sh /usr/local
      }

      swap_create "${MEMORY_SIZE}"
      docker_engine_install
      docker_compose_install
      nodejs_install
      grunt_install
      bats_install
    SHELL

    s.args = [
      MEMORY_SIZE,
    ]
  end
end
