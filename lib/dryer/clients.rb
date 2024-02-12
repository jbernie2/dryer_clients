require "zeitwerk"
require "rubygems"

module Dryer
  module Clients
    def self.version
      Gem::Specification::load(
        "./dryer_clients.gemspec"
      ).version
    end

    def self.loader
      @loader ||= Zeitwerk::Loader.new.tap do |loader|
        root = File.expand_path("..", __dir__)
        loader.tag = "dryer_clients"
        loader.inflector = Zeitwerk::GemInflector.new("#{root}/dryer_clients.rb")
        loader.push_dir(root)
        loader.ignore(
          "#{root}/dryer_clients.rb",
        )
      end
    end
    loader.setup
  end
end
