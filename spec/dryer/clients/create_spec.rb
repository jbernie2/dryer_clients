require_relative "../../../lib/dryer_clients.rb"
require 'dry-validation'

RSpec.describe Dryer::Clients::Create do

  before do
    stub_const("Contracts::FooCreateRequestContract", Class.new(Dry::Validation::Contract) do
      params do
        required(:bar).filled(:string)
      end
    end)

    stub_const("Contracts::FooCreateResponseContract", Class.new(Dry::Validation::Contract) do
      params do
        required(:foo).filled(:string)
      end
    end)
  end

  let(:generated_client) do 
    described_class
      .call(api_desc)
      .success
      .new("https://example.com")
  end

  let(:client) do 
    described_class
      .call(api_desc)
  end

  let(:base_url) { "https://test.com" }
  let(:api_desc) { foo_resource_desc }
  let(:foo_resource_desc) do
    {
      url: "/foos",
      actions: {
        create: {
          method: :post,
          request_contract: Contracts::FooCreateRequestContract,
          response_contracts: {
            200 => Contracts::FooCreateResponseContract,
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
          request_contract: Contracts::FooCreateRequestContract,
          response_contracts: {
            200 => Contracts::FooCreateResponseContract,
          }
        }
      }
    }
  end

  context "when given a valid API description" do
    it "returns a GeneratedClient class" do
      expect(client).to be < Dryer::Clients::GeneratedClient
    end

    context "when the description is an array" do
      let(:api_desc) { [foo_resource_desc, bar_resource_desc] }
      it "returns a GeneratedClient class" do
        expect(client).to be < Dryer::Clients::GeneratedClient
      end
    end

    context "when the resources descriptions are passed as individual arguements" do
      let(:client) do
        described_class.call(
          foo_resource_desc,
          bar_resource_desc
        )
      end

      it "returns a GeneratedClient class" do
        expect(client).to be < Dryer::Clients::GeneratedClient
      end
    end
  end

  context "when given an invalid API description" do
    let(:api_desc) do
      { foo: "bar" }
    end
    it "raises an error" do
      expect{client}.to raise_error(StandardError)
    end
  end

  context "when the API description is nil" do
    let(:api_desc) { nil }
    it "returns a failure" do
      expect{client}.to raise_error(StandardError)
    end
  end
end
