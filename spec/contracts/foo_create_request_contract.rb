require 'dry-validation'

class FooCreateRequestContract < Dry::Validation::Contract
  params do
    required(:bar).filled(:string)
  end
end
