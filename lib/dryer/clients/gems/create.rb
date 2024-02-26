require "dryer_services"
require "fileutils"

module Dryer
  module Clients
    module Gems
      class Create < Dryer::Services::SimpleService
        def initialize(
          api_description:,
          gem_name:,
          output_directory:,
          contract_directory:
        )
          @api_description = api_description
          @gem_name = gem_name
          @output_directory = output_directory
          @contract_directory = contract_directory
        end

        def call
          FileUtils.mkdir_p(output_directory)
          File.open(File.expand_path(gemspec_path), "w") do |f|
            f.write(gemspec)
          end

          FileUtils.mkdir_p("#{output_directory}/lib")
          File.open(File.expand_path(main_executable_path), "w") do |f|
            f.write(main_executable)
          end

          FileUtils.mkdir_p("#{output_directory}/lib/contracts")
          FileUtils.cp_r(File.expand_path(contract_directory), "#{output_directory}/lib")
        end

        private
        attr_reader :api_description, :gem_name, :output_directory, :contract_directory

        def gemspec_path
          "#{output_directory}/#{gem_name}.gemspec"
        end

        def gemspec
          "foo"
        end

        def main_executable_path
          "#{output_directory}/lib/#{gem_name}.rb"
        end

        def main_executable
          "bar"
        end
      end
    end
  end
end
