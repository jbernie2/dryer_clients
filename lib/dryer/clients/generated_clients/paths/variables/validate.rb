require 'dryer_services'

module Dryer
  module Clients
    module GeneratedClients
      module Paths
        module Variables
          class Validate < Dryer::Services::ResultService

            def initialize(path, path_variables)
              @path = path
              @path_variables = path_variables
            end

            def call
              if path_variable_keys.length != path_variables.length
                Failure(
                  StandardError.new(
                    <<~MSG
                      Path #{path} requires #{path_variable_keys.length} variables,
                      #{path_variables} contains #{path_variables.length}.
                    MSG
                  )
                )
              else
                Success()
              end
            end

            private
            attr_reader :path, :path_variables

            def path_variable_keys
              path.scan(/:\w+/)
            end
          end
        end
      end
    end
  end
end
