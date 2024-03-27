require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module ApiDescriptionFiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            gem_module_name:,
            api_description:,
            output_directory:
          )
            @gem_module_name = gem_module_name
            @api_description = api_description
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/api_description.rb",
              contents: api_description_file_contents(stringify_class_names(api_description))
            }
          end

          private
          attr_reader :gem_module_name,
            :output_directory,
            :api_description

          def api_description_file_contents(description)
            <<~FILE
            module #{gem_module_name}
              class ApiDescription
                def self.definition
                  #{description}
                end
              end
            end
            FILE
          end

          def stringify_class_names(description)
            case description
            when Array
              description.map { |h| stringify_hash(h) }
            when Hash
              [ stringify_hash(description) ]
            end
          end

          def stringify_hash(hash)
            hash.inject({}) do |acc, (key, value)|
              acc[key] = case value
                when Class
                  "#{gem_module_name}::#{value.to_s}"
                when Hash
                  stringify_hash(value)
                else
                  value
                end
              acc
            end
          end
        end
      end
    end
  end
end

