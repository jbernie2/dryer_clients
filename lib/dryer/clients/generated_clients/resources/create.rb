require 'dryer_services'

module Dryer
  module Clients
    module GeneratedClients
      module Resources
        class Create < Dryer::Services::SimpleService
          def initialize(resource)
            @resource = resource
          end

          def call

          end

          attr_reader :resource
        end
      end
    end
  end
end
