require 'dry-validation'

class FooCreateResponseContract < Dry::Validation::Contract
  params do
    required(:foo).filled(:string)
  end
end
