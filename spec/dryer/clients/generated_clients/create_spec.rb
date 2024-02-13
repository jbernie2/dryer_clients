require_relative "../../../../lib/dryer_clients.rb"
require 'dry-validation'
require 'debug'

RSpec.describe Dryer::Clients::GeneratedClients::Create do

  before do
    stub_const("FooCreateRequestContract", Class.new(Dry::Validation::Contract) do
      params do
        required(:bar).filled(:string)
      end
    end)

    stub_const("FooCreateResponseContract", Class.new(Dry::Validation::Contract) do
      params do
        required(:foo).filled(:string)
      end
    end)
  end

  let(:client_class) do 
    described_class.call(api_desc)
  end

  let(:client) do 
    client_class.new(base_url)
  end

  let(:base_url) { "https://example.com" }

  let(:api_desc) { foo_resource_desc }
  let(:foo_resource_desc) do
    {
      url: "/foos",
      actions: {
        create: {
          method: :post,
          request_contract: FooCreateRequestContract,
          response_contracts: {
            200 => FooCreateResponseContract,
          }
        }
      }
    }
  end

  let(:bar_resource_desc) do
    {
      url: "/bars",
      actions: {
        create: {
          method: :post,
          request_contract: FooCreateRequestContract,
          response_contracts: {
            200 => FooCreateResponseContract,
          }
        }
      }
    }
  end


  it "takes a single argument, a url, in it's constructor" do
    expect(client_class.new("https://example.com")).to be_a(
      Dryer::Clients::GeneratedClient
    )
  end

  it "has methods for each resource in API" do
    expect(client.foos).to be_a(GeneratedApiResource)
    expect(client.bars).to be_a(GeneratedApiResource)
  end
end
