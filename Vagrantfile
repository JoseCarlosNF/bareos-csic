# -*- mode: ruby -*-
# vi: set ft=ruby :

# UTILIZAÇÃO DE ANSIBLE E VAGRANT PARA DEMONSTRAÇÃO DE USO DO BAREOS COM VIRTUALBOX
#
# Maintainer: Jose Ferreira <joseferreira@ufpa.br>

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")

  config.vm.provision "copy ssh public key", type: "shell",
        inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"

  config.vm.define "director" do |director|
    director.vm.box = "debian/buster64"
    director.vm.hostname = "director"
    director.vm.network :private_network, ip: "192.168.0.2"
  end

  config.vm.define "client" do |client|
    client.vm.box = "debian/buster64"
    client.vm.hostname = "client"
    client.vm.network :private_network, ip: "192.168.0.3"
  end

  # config.vm.provision :ansible do |ansible|
  #   ansible.playbook  = "provisioning/playbook.yml"
  #   ansible.verbose   = false
  #   ansible.groups   = {
  #     "all" => ["director", "client"]
  #   }
  # end

end
