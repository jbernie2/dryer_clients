# Dryer Clients
A gem providing that generates an API client gem based on an api defintion.
The API defintions depend heavily on [dry-validation](https://dry-rb.org/gems/dry-validation/1.8/) contracts
for header/request/response validation

## Installation
add the following to you gemfile
```
gem "dryer_clients"
```

## Usage
To generate a client gem for an API there are two steps:

1. Define the api. [Check out the schema definition here.](./lib/dryer/clients/api_descriptions/description_schema.rb)
Note that this is schema is a subset of the schema used by [dryer_routes](github.com/jbernie/dryer_routes),
so any definition that works with the dryer_routes gem, will also work here.

2. Generate your client. I set up mine as part of a rake task.
```ruby
Dryer::Clients::Gems::Create.call(
  gem_name: 'my_special_gem_name,
  output_directory: './generated/ruby_client,
  api_description: './path_to_my_api_description_file',
  contract_directory: './directory_where_all_my_dry-validation_contracts_are'
)
```

When run, this will output a gem in the specified output directory. It can be published/used like any other
ruby gem.

### Caveats
Due to the loosey goosey nature of how ruby handles module loading, when passing in
the contract directory, make sure that there are no external dependencies outside of
the files passed in (other than the dry-validation gem), otherwise you will get a
'not found' error when the gem tries to load some class that is not included in the gem.

## Development
This gem is set up to be developed using [Nix](https://nixos.org/) and
[ruby_gem_dev_shell](https://github.com/jbernie2/ruby_gem_dev_shell)
Once you have nix installed you can run `make env` to enter the development
environment and then `make` to see the list of available commands

## Contributing
Please create a github issue to report any problems using the Gem.
Thanks for your help in making testing easier for everyone!

## Versioning
Dryer Clients follows Semantic Versioning 2.0 as defined at https://semver.org.

## License
This code is free to use under the terms of the MIT license.
