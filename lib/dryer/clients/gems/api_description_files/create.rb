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
            output_directory:
          )
            @gem_module_name = gem_module_name
            @input_file = input_file
            @output_directory = output_directory
          end

          def call
            contents = File.read(input_file)
            {
              path: "#{output_directory}/#{File.basename(input_file)}",
              contents: encapsulate_in_gem_module(contents)
            }
          end

          private
          attr_reader :gem_module_name,
            :input_file,
            :output_directory

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

