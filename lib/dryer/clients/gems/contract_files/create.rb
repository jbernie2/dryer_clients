require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module ContractFiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            gem_module_name:,
            input_directory:,
            output_directory:
          )
            @gem_module_name = gem_module_name
            @input_directory = input_directory
            @output_directory = output_directory
          end

          def call
            input_paths.map do |input|
              contents = File.read(input)
              {
                path: output_path(input),
                contents: encapsulate_in_gem_module(contents)
              }
            end
          end

          private
          attr_reader :gem_module_name,
            :input_directory,
            :output_directory

          def input_paths
            Dir["#{input_directory}/**/*"].reject { |fn| File.directory?(fn) }
          end

          def output_path(input_path)
            output_directory + input_path.gsub(input_directory, "")
          end

          def encapsulate_in_gem_module(file_contents)
            <<~FILE
            module #{gem_module_name}
              #{file_contents}
            end
            FILE
          end
        end
      end
    end
  end
end

