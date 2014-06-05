#
# Cookbook Name:: ec-tools
# Recipe:: default
#
# Copyright 2014, Chef
#
# All rights reserved - Do Not Redistribute
#

# create the client key file if private key content is provided
if node['chef']['config']['private_key_raw']
  directory File.dirname(node['chef']['config']['client_key'])

  file node['chef']['config']['client_key'] do
    content node['chef']['config']['private_key_raw']
  end
end

chef_gem 'knife-opc'

directory File.dirname(node['knife']['admin']['config']) do
  recursive true
end

template node['knife']['admin']['config'] do
  source 'knife-pivotal.rb.erb'
  variables(:node_name => node['chef']['config']['node_name'],
             :client_key => node['chef']['config']['client_key'],
             :chef_server_root => node['chef']['config']['chef_server_root'])
  mode '644'
end

directory File.dirname(node['knife']['admin']['bin']) do
  recursive true
end

template node['knife']['admin']['bin'] do
  source 'knife-opc.erb'
  variables(:knife_config => node['knife']['admin']['config'])
  mode '777'
end

file '/etc/profile.d/chef.sh' do
  content 'export PATH=${PATH}:/opt/opscode/embedded/bin'
end