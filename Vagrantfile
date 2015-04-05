# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "hashicorp/precise32"
	config.vm.network "private_network", ip: "192.168.50.111"

	doc_root = '/vagrant_data/'
	app_root = '/vagrant_data/'

	config.vm.synced_folder './', "/vagrant_data", :create => true, :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775,fmode=775']
	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = "cookbooks"
		chef.add_recipe "apt"
		chef.add_recipe "mongodb::10gen_repo"
		chef.add_recipe "mongodb::default"
		chef.add_recipe "mean"
	    chef.json = {doc_root: doc_root,app_root: app_root}
	end

end
