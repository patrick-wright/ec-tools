chef_user "fred" do # name => username
  # action :create # default
  first_name 'Fred' # required
  # middle_name '' optional
  last_name 'Mercury' # required
  email 'fred@getchef.com' # required
  password 'bohemian' # required
  pem_file '/path/filename.pem' # optional
end

# chef_org "neworg" do # name => shortname
#   # action :create # default
#   description 'New Organization' # optional
#   validator_file '/path/neworg-validator.pem' # optional
#   associate_users ['fred'] # optional list of existing users to add to 'admins' and 'billing-admins' groups
# end