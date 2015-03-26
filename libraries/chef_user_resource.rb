require 'chef/resource/lwrp_base'

class Chef::Resource::ChefUser < Chef::Resource::LWRPBase
  self.resource_name = 'chef_user'

  actions :create, :delete, :modify
  default_action :create

  attribute :username, :name_attribute => true, :required => true, :kind_of => String
  attribute :first_name, :required => true, :kind_of => String
  attribute :middle_name, :kind_of => String
  attribute :last_name, :required => true, :kind_of => String
  attribute :email, :required => true, :kind_of => String
  attribute :password, :required => true, :kind_of => String
end
