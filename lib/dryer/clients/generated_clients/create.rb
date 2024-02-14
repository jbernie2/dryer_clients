require 'dryer_services'

module Dryer
  module Clients
    module GeneratedClients
      class Create < Dryer::Services::SimpleService
        def initialize(api_desc)
          @api_desc = api_desc
        end

        def call
          api_desc.inject(Class.new(GeneratedClient)) do |client, resource|
            resource_object = Resources::Create.call(resource)
            client.send(
              :define_method,
              ApiDescriptions::Resources::GenerateName.call(resource)
            ) do
              resource_object.new(self.base_url)
            end
            client
          end
        end

        attr_reader :api_desc
      end
    end
  end
end
