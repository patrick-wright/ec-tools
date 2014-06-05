#
# Cookbook Name:: ec-tools
# Recipe:: default
#
# Copyright 2014, Chef
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'knife-opc'

file '/etc/profile.d/chef.sh' do
  content 'export PATH=${PATH}:/opt/opscode/embedded/bin'
end