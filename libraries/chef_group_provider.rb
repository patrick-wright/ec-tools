require 'chef/provider/lwrp_base'

class Chef::Provider::ChefGroup < Chef::Provider::LWRPBase
  use_inline_resources if defined?(:use_inline_resources)

  def whyrun_supported?
    true
  end

  action :add do
    converge_by("Create #{ @new_resource }") do
      g = EcTools::ChefGroup.new(@new_resource,
      :node_name => node['chef']['config']['node_name'],
      :client_key => node['chef']['config']['client_key'],
      :chef_server_root => node['chef']['config']['chef_server_root'])
      g.add
    end
  end

  def chef_group
    @chef_group ||= EcTools::ChefGroup.new(@new_resource,
      :node_name => node['chef']['config']['node_name'],
      :client_key => node['chef']['config']['client_key'],
      :chef_server_root => node['chef']['config']['chef_server_root'])
  end
end
