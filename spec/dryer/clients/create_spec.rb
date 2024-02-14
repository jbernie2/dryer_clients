require_relative "../../../lib/dryer_clients.rb"
require 'dry-validation'

RSpec.describe Dryer::Clients::Create do

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

  context "when given a valid API description" do
    it "returns a success" do
      expect(client).to be_a(Dry::Monads::Success)
    end

    it "returns a GeneratedClient class" do
      expect(client.success).to be < Dryer::Clients::GeneratedClient
    end

    context "when the description is an array" do
      let(:api_desc) { [foo_resource_desc, bar_resource_desc] }
      it "returns a success" do
        expect(client).to be_a(Dry::Monads::Success)
      end
    end

    context "when the resources descriptions are passed as individual arguements" do
      let(:client) do
        described_class.call(
          foo_resource_desc,
          bar_resource_desc
        )
      end

      it "returns a success" do
        expect(client).to be_a(Dry::Monads::Success)
      end
    end
  end

  context "when given an invalid API description" do
    let(:api_desc) do
      { foo: "bar" }
    end
    it "returns a failure" do
      expect(client).to be_a(Dry::Monads::Failure)
    end
  end

  context "when the API description is nil" do
    let(:api_desc) { nil }
    it "returns a failure" do
      expect(client).to be_a(Dry::Monads::Failure)
    end
  end
end
