#
# Cookbook Name:: docker-chef
# Recipe:: default
#
# This recipe is the defaul recipe for this cookbook. Its use is to prepare the environment for the deployment of the other services.
#

# Installing Apache 

include_recipe "apache2"
include_recipe "apache2::mod_rewrite"

package 'httpd'
package 'openssl'
package 'mod_ssl'

# Create DocumentRoot and site content

directory "#{node['apache']['conf']}/conf.d" do
   recursive true
end

file "#{node['apache']['docroot']}/index.html" do
  content '<html>Hello World!</html>'
  mode '0755'
end

execute "Add conf.d to configurations" do
   command "echo 'Include #{node['apache']['conf']}/conf.d/*.conf' >> #{node['apache']['conf']}/conf/httpd.conf"
   action :run
end

# Use web_app to create configurations for my_site
web_app "my_site" do
  server_name "#{node['apache']['conf']}"
  server_aliases ["www.#{node['apache']['conf']}"]
  docroot "#{node['apache']['docroot']}"
end

apache_site "default" do
  enable true
end

