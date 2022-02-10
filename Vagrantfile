# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'getoptlong'

opts = GetoptLong.new(
  [ '--local', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--do-install', GetoptLong::OPTIONAL_ARGUMENT ]
)

install_from_local = "no"
do_install = "yes"

opts.each do |opt, arg|
  case opt
    when '--local'
      install_from_local = arg
    when '--do-install'
      do_install = arg
  end
end

Vagrant.configure("2") do |config|

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "generic/fedora35"
    fedora.vm.provider "libvirt"
    if do_install == "yes"
      fedora.vm.provision "shell", inline: <<-SHELL
        sudo dnf -y install git ansible
      SHELL
    end
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/impish64"
    ubuntu.vm.provider "virtualbox"
    if do_install == "yes"
      ubuntu.vm.provision "shell", inline: <<-SHELL
        sudo apt-get -y update
        sudo apt-get -y install git ansible
      SHELL
    end
  end

  if install_from_local == "yes"
    config.vm.synced_folder ".", "/home/vagrant/termenv"
  end

  if do_install == "yes"
    ["fedora","ubuntu"].each do |distro|
      config.vm.define distro do |install|
        if install_from_local == "no"
          install.vm.provision "shell", privileged: false, inline: <<-SHELL
            git clone https://github.com/jazik/termenv.git
          SHELL
        end
        install.vm.provision "shell", privileged: false, inline: <<-SHELL
          cd termenv
          ansible-playbook -i hosts termenv.yml
        SHELL
      end
    end
  end

end
