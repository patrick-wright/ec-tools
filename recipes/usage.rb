myuser='fred5'

chef_user myuser do # name => username
  # action :create # default
  first_name 'Fred' # required
  # middle_name '' optional
  last_name 'Mercury' # required
  email "#{myuser}@getchef.com" # required
  password 'bohemian' # required
end

# chef_org "neworg" do # name => shortname
#   # action :create # default
#   description 'New Organization' # optional
#   validator_file '/path/neworg-validator.pem' # optional
#   associate_users ['fred'] # optional list of existing users to add to 'admins' and 'billing-admins' groups
# end