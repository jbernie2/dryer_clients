module Dryer
  module Clients
    module GeneratedClients
      class Response
        def initialize(raw_response:, errors:)
          @raw_response = raw_response
          @errors = errors
        end

        def code
          raw_response.code
        end

        def body
          raw_response.body
        end

        attr_reader :raw_response, :errors
      end
    end
  end
end
