require_relative "../../../../../lib/dryer_clients.rb"
require_relative "../../../../contracts/foo_create_request_contract.rb"
require_relative "../../../../contracts/foo_create_response_contract.rb"
require 'net/http'
require 'json'

RSpec.describe Dryer::Clients::GeneratedClients::Resources::Create do
  let(:resource) { described_class.call(resource_config) }
  let(:base_url) { "https://base.url" }
  let(:resource_config) do
    {
      url: "/foos",
      actions: {
        create: {
          method: :post,
          request_contract: FooCreateRequestContract,
          response_contracts: {
            200 => FooCreateResponseContract,
          }
        },
        show: {
          url: "/foos/:id",
          method: :get,
          response_contracts: {
            200 => FooCreateResponseContract,
          }
        },
        update: {
          url: "/foos/:id",
          method: :patch,
          request_contract: FooCreateRequestContract,
          response_contracts: {
            200 => FooCreateResponseContract,
          }
        }
      }
    }
  end

  it "returns a resource class" do
    expect(resource).to be < Dryer::Clients::GeneratedClients::Resource
  end

  context "when it adds methods for each action" do
    it "names the method based on the action name" do
      expect(resource.instance_methods - Object.instance_methods).to include(:create)
      expect(resource.instance_methods - Object.instance_methods).to include(:show)
      expect(resource.instance_methods - Object.instance_methods).to include(:update)
    end
  end

  context "when initializing the resource" do
    it "accepts a base url, and returns an instance of Resource" do
      expect(resource.new(base_url)).to be_a(Dryer::Clients::GeneratedClients::Resource)
    end
  end 

  context "when calling an action" do

    let(:http) { instance_double(Net::HTTP, send_request: "foo") }
    before do
      allow(Net::HTTP)
        .to receive(:start).and_yield(http)
    end

    it "sends a request to the url, with the provided path variables, headers, and body" do

      resource.new(base_url).update(
        "foo_id",
        headers: { bar: "baz" },
        body: { quux: "wat" }
      )

      expect(Net::HTTP)
        .to have_received(:start).with("base.url", 443, use_ssl: true)

      expect(http)
        .to have_received(:send_request)
        .with(
          "PATCH",
          "/foos/foo_id",
          { quux: "wat" }.to_json,
          { bar: "baz" }
        )
    end
  end
end
