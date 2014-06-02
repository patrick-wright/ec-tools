require 'chef/config'

def whyrun_supported?
  true
end

def create_chef_user

end

def user_exists?
  chef_rest = Chef::REST.new(configure_chef)
  result = chef_rest.get_rest("users/#{@new_resource.username}") # what happens when user does not exist (exc or nil or '')
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