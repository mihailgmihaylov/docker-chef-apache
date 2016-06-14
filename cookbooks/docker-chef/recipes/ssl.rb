#
# Cookbook Name:: docker-chef
# Recipe:: ssl
#
# Thic recipe will create ssl key and certificate and enable ssl for the apache site
#

# Using the predefined template ssl.conf.erb to configure SSL for apache 
template "#{node['apache']['conf']}/conf.d/ssl.conf" do
        source "ssl.conf.erb"
        mode 0644
        owner "root"
        group "root"
        variables(
                :sslcertificate => "#{node['apache']['sslpath']}/apache.crt",
                :sslkey => "#{node['apache']['sslpath']}/apache.key",
                :servername => "#{node['apache']['servername']}",
                :docroot => "#{node['apache']['docroot']}"
        )
end

execute "Generate Certs" do
   command "openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj \"/C=BG/ST=Sofia/L=Sofia/O=Dis/CN=my-site.localhost\" -keyout #{node['apache']['sslpath']}/apache.key -out #{node['apache']['sslpath']}/apache.crt"
   action :run
end

file "#{node['apache']['sslpath']}/apache.key" do
  mode '0755'
end

file "#{node['apache']['sslpath']}/apache.crt" do
  mode '0755'
end

