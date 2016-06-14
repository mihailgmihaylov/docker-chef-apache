#
# Cookbook Name:: docker-chef
# Recipe:: redirect
#
#
# This recipe is used to create a redirect rule for all http traffic to https

ruby_block "Add link to redirect rules in HTTP virtualhost" do
  block do
    fe = Chef::Util::FileEdit.new("#{node['apache']['conf']}/sites-available/my_site.conf")
    fe.insert_line_after_match("RewriteEngine On",
                               "   Include #{node['apache']['conf']}/mods-available/mod_rewrite.conf")
    fe.write_file
  end
end

file "#{node['apache']['conf']}/mods-available/mod_rewrite.conf" do
  content <<-EOF
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}$1 [R=301,L]
  EOF
  mode '0755'
end

link "#{node['apache']['conf']}/mods-enabled/mod_rewrite.conf" do
  to "#{node['apache']['conf']}/mods-available/mod_rewrite.conf"
end

