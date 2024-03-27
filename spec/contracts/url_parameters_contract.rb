require 'dry-validation'

module Contracts
  class UrlParametersContract < Dry::Validation::Contract
    params do
      required(:query).filled(:string)
    end
  end
end
