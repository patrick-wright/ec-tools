ec-tools Cookbook
=================
Installs Enterprise Chef tools and provides custom resources

Attributes
----------
#### ec-tools::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef']['config']['node_name']</tt></td>
    <td>String</td>
    <td>Chef config node name</td>
    <td><tt>pivotal</tt></td>
  </tr>
    <tr>
    <td><tt>['chef']['config']['client_key']</tt></td>
    <td>String</td>
    <td>Chef config client key</td>
    <td><tt>/etc/opscode/pivotal.pem</tt></td>
  </tr>
  </tr>
    <tr>
    <td><tt>['chef']['config']['chef_server_root']</tt></td>
    <td>String</td>
    <td>Chef config server root</td>
    <td><tt>https://localhost</tt></td>
  </tr>
  </tr>
  <tr>
    <td><tt>['chef']['config']['private_key_raw']</tt></td>
    <td>String</td>
    <td>Chef config private key string.  Creates ['chef']['config']['client_key'] with provided key value if configured</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['knife']['admin']['config']</tt></td>
    <td>String</td>
    <td>Knife config file for admin</td>
    <td><tt>/opt/opscode/embedded/conf/knife-pivotal.rb</tt></td>
  </tr>
  <tr>
    <td><tt>['knife']['admin']['bin']</tt></td>
    <td>String</td>
    <td>knife-opc bin file</td>
    <td><tt>/opt/opscode/embedded/bin/knife-opc</tt></td>
  </tr>
</table>


Usage
-----
#### ec-tools::default
* Adds Chef bin dir to system path

##### knife-opc
* Installs the knife-opc gem
* Creates a knife-opc bin script which is preconfigured and ready to execute

   ```bash
   knife-opc user list
   ```
* Provides chef_user, chef_org, chef_group resources

   ```ruby
   myuser = 'fred'

   chef_user myuser do
      action :create
      first_name 'Fred'
      last_name 'Mercury'
      email "#{myuser}@getchef.com"
      password 'bohemian'
   end

    chef_org 'neworg' do
      action :create
      description 'My Organization'
      users myuser # associates user with org. Supports String or an Array of users.
   end

   [ 'admins', 'billing-admins' ].each do |group|
     chef_group group do
       action :add
       org myuser
       users [ myuser ]
     end
   end
```
  * When a user is created the private key is saved as a databag item (user/fred.json, org/neworg.json)

Plans
-----
* add more knife-opc commands as resources
* install knife-acl and knife-opc-backup
* add knife-acl and knife-opc-backup commands as resources
* chef server status resources (commands as well?)

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Patrick Wright
