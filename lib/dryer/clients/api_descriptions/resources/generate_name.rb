require 'dryer_services'

module Dryer
  module Clients
    module ApiDescriptions
      module Resources
        class GenerateName < Dryer::Services::SimpleService
          def initialize(resource)
            @resource = resource
          end

          def call
            resource[:url]
              .split("/")
              .reject { |part| part.start_with?(":") }
              .reject { |part| part.empty? }
              .join("_")
          end

          attr_reader :resource
        end
      end
    end
  end
end

