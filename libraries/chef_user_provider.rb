require 'chef/provider/lwrp_base'

class Chef::Provider::ChefUser < Chef::Provider::LWRPBase
  use_inline_resources if defined?(:use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    unless chef_user.exists? 
      converge_by("Create #{ @new_resource }") do
        @chef_user.create
      end
    end
  end

  action :delete do
    if chef_user.exists?
      converge_by("Delete #{ @new_resource }") do
        chef_user.delete
      end
    end
  end

  def chef_user
    @chef_user ||= EcTools::ChefUser.new(@new_resource, 
      :node_name => node['chef']['config']['node_name'], 
      :client_key => node['chef']['config']['client_key'], 
      :chef_server_root => node['chef']['config']['chef_server_root'])
  end
end
