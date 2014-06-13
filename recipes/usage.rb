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
