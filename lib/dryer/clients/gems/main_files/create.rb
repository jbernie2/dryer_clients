require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module MainFiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            gem_name:,
            gem_module_name:,
            output_directory:
          )
            @gem_name = gem_name
            @gem_module_name = gem_module_name
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/#{gem_name}.rb",
              contents: file_contents
            }
          end

          private
          attr_reader :gem_name, :gem_module_name, :output_directory

          def file_contents
            <<~MAIN
              require "dryer_clients"
              require "zeitwerk"
              loader = Zeitwerk::Loader.for_gem
              loader.setup

              module #{gem_module_name}

              end
            MAIN
          end
        end
      end
    end
  end
end

