require 'dry-validation'

module Contracts
  class HeadersContract < Dry::Validation::Contract
    params do
      required(:important).filled(:string)
    end
  end
end
