myuser = 'fred06'

chef_user myuser do
  first_name 'Fred'
  last_name 'Mercury'
  email "#{myuser}@getchef.com"
  password 'bohemian'
end

chef_user 'thedude' do
  first_name 'Fred'
  last_name 'Mercury'
  email "thedude@getchef.com"
  password 'bohemian'
end

chef_org myuser do
  description 'New Organization'
  users [ myuser, 'thedude' ]
end