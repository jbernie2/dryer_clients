require 'dryer_services'

module Dryer
  module Clients
    module GeneratedClients
      module Resources
        class Create < Dryer::Services::SimpleService
          def initialize(config)
            @config = config
          end

          def call
            config[:actions].inject(Class.new(Resource)) do |resource, (action_name, action_config)|

              # if I don't set a variable to config it is not in scope
              # for the method definition
              resource_config = config

              resource.send(
                :define_method,
                action_name.to_sym
              ) do |*path_variables, **options|
                headers = options[:headers] || {}
                body = options[:body] || {}

                Request.new(
                  base_url: self.base_url,
                  method: action_config[:method],
                  path: action_config[:url] || resource_config[:url],
                  path_variables: path_variables,
                  headers: headers,
                  body: body,
                ).send
              end
              resource
            end
          end

          attr_reader :config
        end
      end
    end
  end
end
