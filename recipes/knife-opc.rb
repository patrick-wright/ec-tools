include_recipe 'ec-tools::default'

chef_gem 'knife-opc' do
  compile_time true
end

# create the client key file if private key content is provided
if node['chef']['config']['private_key_raw']
  directory File.dirname(node['chef']['config']['client_key'])

  file node['chef']['config']['client_key'] do
    content node['chef']['config']['private_key_raw']
  end
end

directory File.dirname(node['knife']['admin']['config']) do
  recursive true
end

template node['knife']['admin']['config'] do
  source 'knife-pivotal.rb.erb'
  variables(:node_name => node['chef']['config']['node_name'],
             :client_key => node['chef']['config']['client_key'],
             :chef_server_root => node['chef']['config']['chef_server_root'])
  mode '644'
end

directory File.dirname(node['knife']['admin']['bin']) do
  recursive true
end

template node['knife']['admin']['bin'] do
  source 'knife-opc.erb'
  variables(:knife_config => node['knife']['admin']['config'])
  mode '777'
end
