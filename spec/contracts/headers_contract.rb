require 'dry-validation'

class HeadersContract < Dry::Validation::Contract
  params do
    required(:important).filled(:string)
  end
end
