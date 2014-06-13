# myuser = 'fred07'
# myuser1 = 'thedude1'

# chef_user myuser do
#   first_name 'Fred'
#   last_name 'Mercury'
#   email "#{myuser}@getchef.com"
#   password 'bohemian'
# end

# chef_user myuser1 do
#   first_name 'Fred'
#   last_name 'Mercury'
#   email "#{myuser1}@getchef.com"
#   password 'bohemian'
# end

# chef_org myuser do
#   description 'New Organization'
#   users [ myuser, myuser1 ]
# end

# [ 'admins', 'billing-admins' ].each do |group|
#   chef_group group do
#     action :add # add
#     org myuser
#     users [ myuser ]
#     # clients []
#   end
# end

data_bag('user').each do |u|
  user = data_bag_item('user', u)
  chef_user user['id'] do
    first_name user['first_name']
    middle_name user['middle_name']
    last_name user['last_name']
    email user['email']
    password user['password']
  end
end

data_bag('org').each do |o|
  org = data_bag_item('org', o)
  chef_org org['id'] do
    description org['description']
    users org['users']
  end

  org['groups'].each do |group|
    chef_group group[0] do
      action :add
      org org['id']
      users group[1]
    end
  end
end
