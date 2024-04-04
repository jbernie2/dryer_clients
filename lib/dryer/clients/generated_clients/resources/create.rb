require 'dryer_services'
require 'dry-monads'

module Dryer
  module Clients
    module GeneratedClients
      module Resources
        class Create < Dryer::Services::SimpleService
          include Dry::Monads[:result, :do]

          def initialize(config)
            @config = config
          end

          def call
            config[:actions].inject(Class.new(Resource)) do |resource, (action_name, action_config)|

              # if I don't set a variable to the config it is not in scope
              # for the method definition
              resource_config = config
              request_contract = get_contract(action_config[:request_contract])
              headers_contract = get_contract(action_config[:headers_contract])
              url_parameters_contract = get_contract(action_config[:url_parameters_contract])
              response_contracts = get_contracts(action_config[:response_contracts])

              resource.send(
                :define_method,
                action_name.to_sym
              ) do |*path_variables, **options|
                headers = options[:headers] || {}
                body = options[:body] || {}
                url_parameters = options[:url_parameters] || {}

                Requests::Validate.call(
                  path_variables: path_variables,
                  headers: headers,
                  body: body,
                  url_parameters: url_parameters,
                  request_contract: request_contract,
                  headers_contract: headers_contract,
                  url_parameters_contract: url_parameters_contract,
                  path: action_config[:url] || resource_config[:url]
                ).bind do |_|
                  raw_response = Request.new(
                    base_url: self.base_url,
                    method: action_config[:method],
                    path: action_config[:url] || resource_config[:url],
                    path_variables: path_variables,
                    headers: headers,
                    body: body,
                  ).send

                  Responses::Create.call(
                    raw_response: raw_response,
                    response_contracts: action_config[:response_contracts]
                  )
                rescue URI::InvalidURIError => e
                  Dry::Monads::Failure(e)
                end
              end
              resource
            end
          end

          attr_reader :config

          def get_contracts(hash)
            hash.inject({}) do |acc, (k,v)|
              acc[k] = get_contract(v)
            end
          end

          def get_contract(contract)
            case contract
            when String
              Module.const_get(contract)
            when Class
              contract
            end
          end
        end
      end
    end
  end
end
