# encoding: utf-8

execute "apt-get update" do
  action :nothing
  command "apt-get update"
end

packages = %w{build-essential bash vim git curl}
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

nodejs_npm 'grunt-cli'
nodejs_npm 'yo'
nodejs_npm 'bower'

service 'apache2' do
  action :stop
end

execute 'npm package install' do
    command "su vagrant -l -c 'cd #{node[:app_root]}; npm install --silent'"
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
