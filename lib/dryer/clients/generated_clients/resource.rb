module Dryer
  module Clients
    module GeneratedClients
      class Resource
        def initialize(base_url)
          @base_url = base_url
        end

        private
        attr_reader :base_url
      end
    end
  end
end
