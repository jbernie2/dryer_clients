require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module Gemfiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            output_directory:
          )
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/Gemfile",
              contents: file_contents
            }
          end

          private
          attr_reader :output_directory

          def file_contents
            <<~GEMFILE
              source 'http://rubygems.org'
              gemspec
            GEMFILE
          end
        end
      end
    end
  end
end

