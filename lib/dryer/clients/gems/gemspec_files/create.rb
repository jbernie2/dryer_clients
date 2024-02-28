require "dryer_services"
require "fileutils"
require 'pathname'
require "debug"

module Dryer
  module Clients
    module Gems
      module GemspecFiles
        class Create < Dryer::Services::SimpleService
          def initialize(
            gem_name:,
            output_directory:
          )
            @gem_name = gem_name
            @output_directory = output_directory
          end

          def call
            {
              path: "#{output_directory}/#{gem_name}.gemspec",
              contents: file_contents
            }
          end

          private
          attr_reader :gem_name,
            :output_directory

          def file_contents
            <<~GEMSPEC
              Gem::Specification.new do |spec|
                spec.name                  = '#{gem_name}'
                spec.version               = "0.0.1"
                spec.authors               = ['']
                spec.email                 = ['']
                spec.summary               = 'Http client generated using dryer_clients gem'
                spec.description           = <<~DOC
                  An Http client generated from an API description using the dryer_clients gem
                DOC
                spec.license               = 'MIT'
                spec.platform              = Gem::Platform::RUBY
                spec.required_ruby_version = '>= 3.0.0'
                spec.files = Dir[
                  '#{gem_name}.gemspec',
                  'README.md',
                  'LICENSE',
                  'CHANGELOG.md',
                  'lib/**/*.rb',
                  '.github/*.md',
                  'Gemfile'
                ]
                spec.add_dependency "dryer_clients", "~> 0.0"
              end
            GEMSPEC
          end
        end
      end
    end
  end
end

