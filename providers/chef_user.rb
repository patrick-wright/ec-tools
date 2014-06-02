def whyrun_supported?
  true
end

def create_chef_user

end

def user_exists?
  username = @new_resource.username
  chef_rest = Chef::REST.new(Chef::Config[:chef_server_root]) # will need to config Chef::Config via api
  result = @chef_rest.get_rest("users/#{user_name}") # what happens when user does not exist (exc or nil or '')
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

end