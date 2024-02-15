require 'dryer_services'

module Dryer
  module Clients
    module GeneratedClients
      module Responses
        class Create < Dryer::Services::ResultService
          def initialize(
            raw_response:,
            response_contracts:
          )
            @raw_response = raw_response
            @response_contracts = response_contracts
          end

          def call
            errors = validation_errors(
              raw_response.body,
              response_contracts[raw_response.code]
            )

            if errors.empty?
              Success(
                Response.new(
                  raw_response: raw_response,
                  errors: errors
                )
              )
            else
              Failure(
                StandardError.new({
                  code: raw_response.code,
                  body: raw_response.body,
                  errors: errors.to_h
                })
              )
            end
          end

          private
          def validation_errors(payload, contract)
            if contract.nil?
              []
            elsif is_json?(payload)
              contract.new.call(JSON.parse(payload)).errors
            end
          end

          def is_json?(str)
            JSON.parse(str)
            true
          rescue JSON::ParserError, TypeError => e
            false
          end

          attr_reader :raw_response, :response_contracts
        end
      end
    end
  end
end
