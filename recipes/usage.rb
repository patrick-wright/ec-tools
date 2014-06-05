# create the client key file if private key content is provided
if node['chef']['config']['private_key_raw']
  directory File.dirname(node['chef']['config']['client_key'])

  file node['chef']['config']['client_key'] do
    content node['chef']['config']['private_key_raw']
  end
end

# myuser = 'fred20'

# chef_user myuser do # name => username
#   # action :create # default
#   first_name 'Fred' # required
#   # middle_name '' optional
#   last_name 'Mercury' # required
#   email "#{myuser}@getchef.com" # required
#   password 'bohemian' # required
# end

# chef_org "neworg" do # name => shortname
#   # action :create # default
#   description 'New Organization' # optional
#   validator_file '/path/neworg-validator.pem' # optional
#   associate_users ['fred'] # optional list of existing users to add to 'admins' and 'billing-admins' groups
# end