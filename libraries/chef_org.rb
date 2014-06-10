module EcTools
  class ChefOrg

    # make this a parent class "or some cool ruby thing" that gets inherited for "opc" classes
    def initialize(new_resource, config = {}) 
      @new_resource = new_resource
      
      # make setting Chef::Config dynamic by iterating through options
      # currently sets chef_server_root (and it doesn't have to)
      config.each do |k, v|
        Chef::Config[k] = v
      end
      @rest = Chef::REST.new(config[:chef_server_root])
      
      @org_databag = Chef::DataBag.new
      @org_databag.name('org')
      @org_databag.save
    end

    def create
      org_hash = {
        :name =>     @new_resource.name,
        :full_name =>   @new_resource.description
      }
      response = @rest.post_rest("organizations/", org_hash)

      Chef::Log.debug("#{@new_resource}:#{response}")

      # preparing for databag item
      data = {
        "id" => "#{@new_resource.name}",
        "private_key" => response['private_key']
      }

      databag_item = Chef::DataBagItem.new
      databag_item.data_bag(@org_databag.name)
      databag_item.raw_data = data
      databag_item.save

      associate_user(@new_resource.users, @new_resource.name) if @new_resource.users.is_a?(String)
      @new_resource.users.each { |user| associate_user(user, @new_resource.name) } if @new_resource.users.is_a?(Array)
    end

    def delete
    end

    def associate_user(username, org_name)
      response = @rest.post_rest "organizations/#{org_name}/association_requests", { :user => username }
      association_id = response["uri"].split("/").last
      @rest.put_rest "users/#{username}/association_requests/#{association_id}", { :response => 'accept' }
    end

    def exists?
      # yeah, please fix this, Patrick
      begin
        if @rest.get_rest("organizations/#{@new_resource.name}")
          Chef::Log.info ("#{@new_resource.name} exists")
          return true
        end
      rescue Net::HTTPServerException => e # should check for 404 in message or others and handle them differently
        if e.message.include? '404'
          Chef::Log.debug ("#{@new_resource.name} does not exist")
        end
      end
       return false
    end
  end
end
