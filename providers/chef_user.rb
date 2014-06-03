require 'chef/config'
require 'chef/provider/lwrp_base'

class Chef::Provider::ChefUser < Chef::Provider::LWRPBase

  def whyrun_supported?
    true
  end

  def create_chef_user
    user_hash = {
        :username =>     @new_resource.username,
        :first_name =>   @new_resource.first_name,
        :middle_name =>  @new_resource.middle_name,
        :last_name =>    @new_resource.last_name,
        :display_name => "#{@new_resource.first_name} #{@new_resource.last_name}",
        :email =>        @new_resource.email,
        :password =>     @new_resource.password
      }
    @chef_rest.post_rest("users/", user_hash)
  end

  def delete_chef_user

  end

  def user_exists?
    begin
      return true if @chef_rest.get_rest("users/#{@new_resource.username}")
    rescue Net::HTTPServerException => e # should check for 404 in message
      Chef::Log.debug("#{@new_resource.username} does not exist")
    end
    return false
  end

  action :create do
    unless user_exists? 
      converge_by("Create #{ @new_resource }") do
        create_chef_user
      end
    end
  end


  action :delete do
    if user_exists?
      converge_by("Delete #{ @new_resource }") do
        delete_chef_user
      end
    end
  end

  # action :modify do
  # end

  def configure_chef
    Chef::Config[:node_name] = node['chef']['config']['node_name']
    Chef::Config[:client_key] = node['chef']['config']['client_key']
    Chef::Config[:chef_server_url] = node['chef']['config']['chef_server_root']
  end

  def load_current_resource
    @chef_rest = Chef::REST.new(configure_chef)
  end
end
