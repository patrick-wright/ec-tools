module EcTools
  class EcChefGroup

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

    def add
      @new_resource.users.each { |username|
        group = @rest.get_rest "organizations/#{@new_resource.org}/groups/#{@new_resource.group}"
        group_hash = {
          :groupname => "#{@new_resource.group}",
          :actors => {
            "users" => group["actors"].concat([username]),
            "groups" => group["groups"]
          }
        }
        @rest.put_rest "organizations/#{@new_resource.org}/groups/#{@new_resource.group}", group_hash
      }
    end
  end
end
