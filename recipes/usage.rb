chef_user "fred" do
  action :create
  first_name 'Fred'
  #middle_name '' optional
  last_name 'Mercury'
  email 'fred@getchef.com'
  password 'bohemian'
  pem_file '/path/filename.pem' # optional
end