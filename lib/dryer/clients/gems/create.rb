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
          ContractFiles::Create.call(
            gem_module_name: camelize(gem_name),
            input_directory: contract_directory,
            output_directory: contract_output_dir
          ).append(
            ApiDescriptionFiles::Create.call(
              gem_module_name: camelize(gem_name),
              input_file: api_description_file,
              output_directory: dependencies_dir
            )
          ).append(
            ClientFiles::Create.call(
              gem_module_name: camelize(gem_name),
              api_description_class_name: api_description_class_name,
              output_directory: dependencies_dir
            )
          ).then do |files|
            files.append(
              MainFiles::Create.call(
                gem_name: gem_name,
                dependencies: files.map { |f| f[:path] },
                output_directory: lib_dir,
              )
            )
            files.append(
              Gemfiles::Create.call(output_directory: output_directory)
            )

            gemspec = GemspecFiles::Create.call(
              gem_name: gem_name,
              output_directory: output_directory
            )
            File.exist?(gemspec[:path]) ? files : files.append(gemspec)
          end.map do |file|
            FileUtils.mkdir_p(File.dirname(file[:path]))
            File.open(File.expand_path(file[:path]), "w") do |f|
              f.write(file[:contents])
            end
          end

          output_directory
        end

        private
        attr_reader :api_description_file,
          :api_description_class_name,
          :gem_name,
          :output_directory,
          :contract_directory

        def lib_dir
          "#{output_directory}/lib"
        end

        def dependencies_dir
          "#{lib_dir}/#{gem_name}"
        end

        def contract_output_dir
          "#{dependencies_dir}/contracts"
        end

        def camelize(str)
          str.split(/[\-_]/).map{|e| e.capitalize}.join
        end
      end
    end
  end
end
