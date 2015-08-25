require 'chef/resource/lwrp_base'

class Chef::Resource::EcChefGroup < Chef::Resource::LWRPBase
  self.resource_name = 'ec_chef_group'

  actions :add, :remove # group must currently exist
  default_action :add

  attribute :group, :name_attribute => true, :required => true, :kind_of => String
  attribute :org, :required => true, :kind_of => String
  attribute :users, :kind_of => [ String, Array ]
  attribute :clients, :kind_of => [ String, Array ]
end
