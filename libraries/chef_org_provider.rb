require 'chef/provider/lwrp_base'

class Chef::Provider::ChefOrg < Chef::Provider::LWRPBase
  use_inline_resources if defined?(:use_inline_resources)

  def whyrun_supported?
    true
  end

  action :create do
    unless chef_org.exists? 
      converge_by("Create #{ @new_resource }") do
        @chef_org.create
      end
    end
  end

  action :delete do
    if chef_org.exists?
      converge_by("Delete #{ @new_resource }") do
        chef_org.delete
      end
    end
  end

  action :associate_user do
  end

  def chef_org
    @chef_org ||= EcTools::ChefOrg.new(@new_resource, 
      :node_name => node['chef']['config']['node_name'], 
      :client_key => node['chef']['config']['client_key'], 
      :chef_server_root => node['chef']['config']['chef_server_root'])
  end
end
