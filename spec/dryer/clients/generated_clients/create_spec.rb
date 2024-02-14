require_relative "../../../../lib/dryer_clients.rb"
require_relative "../../../contracts/foo_create_request_contract.rb"
require_relative "../../../contracts/foo_create_response_contract.rb"

RSpec.describe Dryer::Clients::GeneratedClients::Create do

  let(:client_class) do 
    described_class.call(api_desc)
  end

  let(:client) do 
    client_class.new(base_url)
  end

  let(:base_url) { "https://example.com" }

  let(:api_desc) { [foo_resource_desc, bar_resource_desc] }
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
    expect(client.foos).to be_a(Dryer::Clients::GeneratedClients::Resource)
    expect(client.bars).to be_a(Dryer::Clients::GeneratedClients::Resource)
  end
end
