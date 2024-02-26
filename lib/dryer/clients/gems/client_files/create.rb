require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module ClientFiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            gem_module_name:,
            api_description_class_name:,
            output_directory:
          )
            @gem_module_name = gem_module_name
            @api_description_class_name = api_description_class_name
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/client.rb",
              contents: file_contents
            }
          end

          private
          attr_reader :gem_module_name,
            :api_description_class_name,
            :output_directory

          def file_contents
            <<~CLIENT
              module #{gem_module_name}
                class Client
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
              end
            CLIENT
          end
        end
      end
    end
  end
end

