require_relative "../lib/dryer_clients.rb"
require_relative "./contracts/foo_create_request_contract.rb"
require_relative "./contracts/foo_create_response_contract.rb"
require 'webmock/rspec'

RSpec.describe Dryer::Clients do
  let(:client) do 
    described_class::Create
      .call(api_desc)
      .success
      .new(base_url)
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

    before do
      stub_request(
        :post, "#{base_url}/foos"
      ).with(
        body: { bar: 'baz' }.to_json,
        headers: {
          quux: 'wat',
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
       }
      ).to_return(
        status: 200, body: {foo: 'bar'}.to_json, headers: {}
      )
    end

    it "builds a client for that api" do
      response = client.foos.create(
        body: { bar: 'baz' },
        headers: { quux: 'wat' },
      )
      expect(response.success.code).to eq("200")
      expect(response.success.body).to eq({foo: 'bar'}.to_json)
    end
  end

  it "can return it's version" do
    expect(described_class.version).to be_truthy
  end

end
