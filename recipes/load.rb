data_bag('user').each do |u|
  user = data_bag_item('user', u)
  ec_chef_user user['id'] do
    first_name user['first_name']
    middle_name user['middle_name']
    last_name user['last_name']
    email user['email']
    password user['password']
  end
end

data_bag('org').each do |o|
  org = data_bag_item('org', o)
  ec_chef_org org['id'] do
    description org['description']
    users org['users']
  end

  org['groups'].each do |group|
    ec_chef_group group[0] do
      action :add
      org org['id']
      users group[1]
    end
  end
end
