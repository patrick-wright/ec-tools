chef_user "fred" do # name => username
  action :create # default
  first_name 'Fred' # required
  # middle_name '' optional
  last_name 'Mercury' # required
  email 'fred@getchef.com' # required
  password 'bohemian' # required
  pem_file '/path/filename.pem' # optional
end