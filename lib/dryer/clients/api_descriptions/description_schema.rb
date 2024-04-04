require 'dry-validation'

module Dryer
  module Clients
    module ApiDescriptions
      class DescriptionSchema < Dry::Validation::Contract

        params do
          required(:url).filled(:string)
          required(:actions).filled(:hash)
        end

        class ActionSchema < Dry::Validation::Contract
          params do
            required(:method).filled(:symbol)
            optional(:request_contract)
            optional(:url_parameters_contract)
            optional(:headers_contract)
            optional(:response_contracts).hash()
          end

          rule(:request_contract) do
            unless valid_contract?(value)
              key.failure('must be a dry-validation contract')
            end
          end

          rule(:url_parameters_contract) do
            unless valid_contract?(value)
              key.failure('must be a dry-validation contract')
            end
          end

          rule(:headers_contract) do
            unless valid_contract?(value)
              key.failure('must be a dry-validation contract')
            end
          end

          rule(:response_contracts) do
            values[:response_contracts].each do |key, value|
              unless valid_contract?(value)
                key(:response_contracts).failure(
                  'must be a dry-validation contract'
                )
              end
            end if values[:response_contracts]
          end

          def valid_contract?(value)
            case value
            when Class
              value <= Dry::Validation::Contract
            when String
              begin
                contract_class = Module.const_get(value)
                contract_class <= Dry::Validation::Contract
              rescue NameError => e
                false
              end
            else
                true
            end
          end
        end

        rule(:actions) do
          values[:actions].each do |key, value|
            res = ActionSchema.new.call(value)
            if !res.success?
              res.errors.to_h.each do |name, messages|
                messages.each do |msg|
                  key([key_name, name]).failure(msg)
                end
              end
            end
          end
        end

      end
    end
  end
end
