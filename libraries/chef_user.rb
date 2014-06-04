module EcTools
  class ChefUser

    # make this a parent class "or some cool ruby thing" that gets inherited for "opc" classes
    def initialize(new_resource, config = {}) 
      @new_resource = new_resource
      
      # make setting Chef::Config dynamic by iterating through options
      # currently sets chef_server_root (and it doesn't have to)
      config.each do |k, v|
        Chef::Config[k] = v
      end
      @rest = Chef::REST.new(config[:chef_server_root])
    end

    def create
      user_hash = {
        :username =>     @new_resource.username,
        :first_name =>   @new_resource.first_name,
        :middle_name =>  @new_resource.middle_name,
        :last_name =>    @new_resource.last_name,
        :display_name => "#{@new_resource.first_name} #{@new_resource.last_name}",
        :email =>        @new_resource.email,
        :password =>     @new_resource.password
      }
      response = @rest.post_rest("users/", user_hash)

      Chef::Log.debug("#{@new_resource}:#{response}")

      # preparing for databags
      data = {
        "id" => "#{@new_resource.username}",
        "uri" => response[:uri],
        "private_key" => response[:private_key]
      }
    end

    def delete
    end

    def exists?
      # yeah, please fix this, Patrick
      begin
        if @rest.get_rest("users/#{@new_resource.username}")
          Chef::Log.info ("#{@new_resource.username} exists")
          return true
        end
      rescue Net::HTTPServerException => e # should check for 404 in message or others and handle them differently
        if e.message.include? '404'
          Chef::Log.debug ("#{@new_resource.username} does not exist")
        end
      end
       return false
    end
  end
end
