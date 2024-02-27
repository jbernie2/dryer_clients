require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      class Create < Dryer::Services::SimpleService
        def initialize(
          gem_name:,
          output_directory:,
          api_description_file:,
          api_description_class_name:,
          contract_directory:
        )
          @api_description_file = api_description_file
          @api_description_class_name = api_description_class_name
          @gem_name = gem_name
          @output_directory = output_directory
          @contract_directory = contract_directory
        end

        def call
          FileUtils.mkdir_p(output_directory)
          File.open(File.expand_path(gemspec_path), "w") do |f|
            f.write(gemspec)
          end

          FileUtils.mkdir_p(lib_dir)
          FileUtils.mkdir_p(contract_output_dir)
          FileUtils.cp_r(File.expand_path(contract_directory), lib_dir)
          FileUtils.cp_r(File.expand_path(api_description_file), lib_dir)

          File.open(File.expand_path(main_executable_path), "w") do |f|
            f.write(main_executable)
          end

          output_directory
        end

        private
        attr_reader :api_description_file,
          :api_description_class_name,
          :gem_name,
          :output_directory,
          :contract_directory

        def gemspec_path
          "#{output_directory}/#{gem_name}.gemspec"
        end

        def gemspec
          "foo"
        end

        def main_executable_path
          "#{lib_dir}/#{gem_name}.rb"
        end

        def main_executable
          <<~MAIN
            require "dryer_clients"
            #{require_contracts}
            #{require_api_desc}\n
            class #{camelize(gem_name)}
              def initialize(base_url)
                @base_url = base_url
              end

              def client
                @client ||= Dryer::Clients::Create.call(
                  #{api_description_class_name}.definition
                ).new(base_url)
              end

              attr_reader :base_url
            end
          MAIN
        end

        def require_contracts
          relative_contract_paths.map do |p|
            "require_relative './#{p}'"
          end.join("\n")
        end

        def require_api_desc
          "require_relative './#{File.basename(api_description_file)}'"
        end

        def lib_dir
          "#{output_directory}/lib"
        end

        def contract_output_dir
          "#{lib_dir}/contracts"
        end

        def contract_paths
          Dir["#{contract_output_dir}/*"].reject {|fn| File.directory?(fn) }
        end

        def relative_contract_paths
          contract_paths.map do |p|
            Pathname.new(p).relative_path_from(lib_dir).to_s
          end
        end

        def camelize(str)
          str
            .split(/[\-_]/).map{|e| e.capitalize}.join
        end
      end
    end
  end
end
