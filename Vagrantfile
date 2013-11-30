VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "base"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  config.vm.hostname = "poker-croupier"

  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :public_network

end
