require 'dryer_services'

module Dryer
  module Clients
    class Create < Dryer::Services::ResultService

      def initialize(api_desc)
        @api_desc = api_desc
      end

      def call

      end

      private
      attr_reader :api_desc
    end
  end
end
