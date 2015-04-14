# encoding: utf-8

execute "apt-get update" do
  action :nothing
  command "apt-get update"
end

packages = %w{gcc make build-essential bash vim git curl libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev}
packages.each do |pkg|
  package pkg do
    options "-o Dpkg::Options::='--force-confold' -f --force-yes"
    action [:install, :upgrade]
    version node[:versions][pkg]
  end
end

Execute "gem install sass" do
    not_if "which sass"
end

npm_global_pacages = %w{node-gyp grunt-cli yo bower}
npm_global_pacages.each do |npm_pkg|
  nodejs_npm npm_pkg do
    user 'vagrant'
  end
end

service 'apache2' do
  action :stop
end

execute 'npm package install' do
  command "sudo npm cache clean -g"
  command "su vagrant -l -c 'cd #{node[:app_root]}; npm cache clean'"
  command "su vagrant -l -c 'cd #{node[:app_root]}; npm install'"
end

execute 'bower package install' do
    command "su vagrant -l -c 'cd #{node[:app_root]}; bower install'"
end

template "/home/vagrant/.bash_profile" do
  owner "vagrant"
  group "vagrant"
  mode 0644
  source ".bash_profile"
end
