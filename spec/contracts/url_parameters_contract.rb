require 'dry-validation'

class UrlParametersContract < Dry::Validation::Contract
  params do
    required(:query).filled(:string)
  end
end
