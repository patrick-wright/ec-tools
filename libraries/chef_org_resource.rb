require 'chef/resource/lwrp_base'

class Chef::Resource::ChefOrg < Chef::Resource::LWRPBase
  self.resource_name = 'chef_org'

  actions :create, :delete, :associate_user
  default_action :create

  attribute :name, :name_attribute => true, :required => true, :kind_of => String
  attribute :description, :kind_of => String
  attribute :users, :kind_of => [ String, Array ]
end
