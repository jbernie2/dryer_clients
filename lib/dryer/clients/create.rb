require 'dryer_services'

module Dryer
  module Clients
    class Create < Dryer::Services::ResultService

      def initialize(*api_desc)
        if api_desc.is_a?(Array) && api_desc[0].is_a?(Array)
          @api_desc = api_desc[0]
        else
          @api_desc = api_desc || []
        end
      end

      def call
        validate_api_description.then do |errors|
          if errors.empty?
            Success(GeneratedClient)
          else
            Failure(errors)
          end
        end
      end

      private
      attr_reader :api_desc

      def validate_api_description
        errors = api_desc.map do |r|
          ApiDescriptions::DescriptionSchema.new.call(r)
        end.select { |r| !r.errors.empty? }

        if !errors.empty?
          messages = errors.inject({}) do |messages, e|
            messages.merge(e.errors.to_h)
          end
          messages
        else
          []
        end
      end
    end
  end
end
