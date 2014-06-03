require 'chef/resource/lwrp_base'

class Chef::Resource::ChefUser < Chef::Resource::LWRPBase
  self.resource_name = 'chef_user'

  actions :create, :delete, :modify
  default_action :create

  attribute :username, :name_attribute => true, :required => true, :kind_of => String 
  attribute :first_name, :required => true, :kind_of => String
  attribute :middle_name, :kind_of => String
  attribute :last_name, :required => true, :kind_of => String
  attribute :email, :required => true, :kind_of => String # email type?
  attribute :password, :required => true, :kind_of => String
  attribute :pem_file, :kind_of => String

  attr_accessor :exists # check if user exists
end