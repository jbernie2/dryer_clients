require 'net/http'

module Dryer
  module Clients
    module GeneratedClients
      class Request
        def initialize(
          base_url:,
          method:,
          path:,
          path_variables:,
          headers:,
          body:
        )
          @base_url = base_url
          @method = method
          @path = path
          @path_variables = path_variables
          @headers = headers
          @body = body
        end

        def send
          uri = URI(base_url)
          Net::HTTP.start(
            uri.host, uri.port, use_ssl: uri.scheme == "https"
          ) do |http|
            http.send_request(
              method.to_s.upcase,
              populated_path,
              body.to_json,
              headers
            )
          end
        end
        
        private
        attr_reader :base_url, :method, :path, :path_variables, :headers, :body

        def populated_path
          path_variable_keys.to_a.zip(path_variables).inject(path) do |path, (key, value)|
            if key && value
              path.sub(key.to_s, value.to_s)
            else
              path
            end
          end
        end

        def path_variable_keys
          path.scan(/:\w+/)
        end
      end
    end
  end
end
