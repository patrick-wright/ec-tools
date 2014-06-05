default['chef']['config']['node_name'] = 'pivotal'
default['chef']['config']['client_key'] = '/etc/opscode/pivotal.pem'
default['chef']['config']['chef_server_root'] = 'https://localhost'
default['chef']['config']['private_key_raw'] = nil
default['knife']['admin']['config'] = '/opt/opscode/embedded/conf/knife-pivotal.rb'
default['knife']['admin']['bin'] = '/opt/opscode/embedded/bin/knife-opc'
