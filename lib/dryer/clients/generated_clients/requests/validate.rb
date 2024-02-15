require 'dryer_services'
require 'dry-monads'

module Dryer
  module Clients
    module GeneratedClients
      module Requests
        class Validate < Dryer::Services::ResultService
          include Dry::Monads[:result, :do]

          def initialize(
            path_variables:,
            path:,
            headers:,
            headers_contract:,
            body:,
            request_contract:,
            url_parameters:,
            url_parameters_contract:
          )
            @path = path
            @path_variables = path_variables
            @headers = headers
            @headers_contract = headers_contract
            @body = body
            @request_contract = request_contract
            @url_parameters = url_parameters
            @url_parameters_contract = url_parameters_contract
          end

          def call
            yield Paths::Variables::Validate.call(path, path_variables)
            yield validate(headers, headers_contract)
            yield validate(body, request_contract)
            yield validate(url_parameters, url_parameters_contract)
          end

          private

          def validate(payload, contract)
            return Success() unless contract

            result = contract.new.call(payload)
            if result.errors.empty?
              Success()
            else
              Failure(StandardError.new(result.errors.to_h))
            end
          end

          attr_reader :path_variables,
            :path,
            :headers,
            :headers_contract,
            :body,
            :request_contract,
            :url_parameters,
            :url_parameters_contract
        end
      end
    end
  end
end
