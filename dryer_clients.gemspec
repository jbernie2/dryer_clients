Gem::Specification.new do |spec|
  spec.name                  = 'dryer_clients'
  spec.version               = "0.1.0"
  spec.authors               = ['John Bernier']
  spec.email                 = ['john.b.bernier@gmail.com']
  spec.summary               = 'Library that leverages dry contracts to generate API clients'
  spec.description           = <<~DOC
    Given a description of an API, generates a ruby client for that API.
  DOC
  spec.homepage              = 'https://github.com/jbernie2/dryer_clients'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.0'
  spec.files = Dir[
    'dryer_clients.gemspec',
    'README.md',
    'LICENSE',
    'CHANGELOG.md',
    'lib/**/*.rb',
    '.github/*.md',
    'Gemfile'
  ]

  spec.add_dependency "zeitwerk", "~> 2.6"
  spec.add_dependency "dry-validation", "~> 1.10"
  spec.add_dependency "dry-monads", "~> 1.6"
  spec.add_dependency "dryer_services", "~> 2.0"

  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "webmock", "~> 3.14"
  spec.add_development_dependency "debug", "~> 1.8"
end
