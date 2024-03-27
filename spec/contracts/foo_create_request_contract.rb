require 'dry-validation'

module Contracts
  class FooCreateRequestContract < Dry::Validation::Contract
    params do
      required(:bar).filled(:string)
    end
  end
end
