execute "apt-get update" do
  action :nothing
  command "apt-get update"
end

apt_repository "nodejs-#{node["lsb"]["codename"]}" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  action :add
end

packages = %w{build-essential nodejs bash vim git curl imagemagick}
packages.each do |pkg|
  package pkg do
    options "-o Dpkg::Options::='--force-confold' -f --force-yes"
    action [:install, :upgrade]
    version node[:versions][pkg]
  end
end

%w{grunt-cli yo bower}.each do |p|
  execute p do
    command 'npm install -g ' + p
 not_if "npm -g ls 2> /dev/null | grep '^[├└]─[─┬] #{p}@'"
  end
end

service 'apache2' do
  action :stop
end

bash "npm install & run grunt init task" do
  code <<-EOS
  cd #{node[:app_root]}Grunt; npm install
  grunt jstask csstask
  EOS
end
