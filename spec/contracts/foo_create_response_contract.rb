require 'dry-validation'

module Contracts
  class FooCreateResponseContract < Dry::Validation::Contract
    params do
      required(:foo).filled(:string)
    end
  end
end
