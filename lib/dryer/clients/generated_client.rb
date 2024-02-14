module Dryer
  module Clients
    class GeneratedClient
      def initialize(base_url)
        @base_url = base_url
      end

      attr_reader :base_url
    end
  end
end
