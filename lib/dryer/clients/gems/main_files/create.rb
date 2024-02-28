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
            dependencies:,
            output_directory:
          )
            @gem_name = gem_name
            @dependencies = dependencies
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/#{gem_name}.rb",
              contents: file_contents
            }
          end

          private
          attr_reader :gem_name,
            :dependencies,
            :output_directory

          def file_contents
            <<~MAIN
              require "dryer_clients"
              #{require_dependencies}
            MAIN
          end

          def require_dependencies
            relative_dependency_paths.map do |p|
              "require_relative './#{p}'"
            end.join("\n")
          end

          def relative_dependency_paths
            dependencies.map do |d|
              Pathname.new(d).relative_path_from(output_directory).to_s
            end
          end
        end
      end
    end
  end
end

