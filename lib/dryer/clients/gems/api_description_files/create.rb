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
            input_file:,
            api_description_class_name:,
            output_directory:
          )
            @gem_module_name = gem_module_name
            @input_file = input_file
            @api_description_class_name = api_description_class_name
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/api_description.rb",
              contents: api_description_file_contents(stringify_description)
            }
          end

          private
          attr_reader :gem_module_name,
            :input_file,
            :output_directory,
            :api_description_class_name

          def api_description_file_contents(description)
            <<~FILE
            module #{gem_module_name}
              class ApiDescription
                def self.definition
                  #{JSON.pretty_generate(description)}
                end
              end
            end
            FILE
          end

          def stringify_description
            require input_file
            stringify_hash(
              Module.const_get(
                api_description_class_name
              ).definition
            )
          end

          def stringify_hash(hash)
            hash.inject({}) do |acc, (key, value)|
              acc[key] = case value
                when Class
                  value.to_s
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

