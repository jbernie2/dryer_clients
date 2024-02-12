require_relative "../lib/dryer_clients.rb"
require 'dry-validation'

RSpec.describe Dryer::Clients do

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

  let(:client) do 
    described_class::Create
      .call(api_desc)
      #.new(base_url)
  end
  let(:base_url) { "https://test.com" }
  let(:api_desc) do
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

  context "when given an API description" do
    it "builds a client for that api" do
      response = client.foos.create(
        body: { bar: 'baz' },
        headers: { quux: 'wat' },
      )
      expect(response.status).to eq(200)
      expect(response.parsed_body).to eq({foo: 'bar'})
    end
  end

  it "can return it's version" do
    expect(described_class.version).to be_truthy
  end

end
