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
    let(:http) do
      instance_double(
        Net::HTTP,
        send_request: response
      )
    end

    let(:response) do
      instance_double(
        Net::HTTPResponse,
        code: 200,
        body: { foo: "boo" }.to_json
      )
    end

    before do
      allow(Net::HTTP)
        .to receive(:start).and_yield(http)
    end

    it "sends a request to the url, with the provided path variables, headers, and body" do
      resource.new(base_url).update(
        "foo_id",
        headers: { bar: "baz" },
        body: { bar: "wat" }
      )

      expect(Net::HTTP)
        .to have_received(:start).with("base.url", 443, use_ssl: true)

      expect(http)
        .to have_received(:send_request)
        .with(
          "PATCH",
          "/foos/foo_id",
          { bar: "wat" }.to_json,
          { bar: "baz" }
        )
    end

    it "returns a success monad containing a response object" do
      response = resource.new(base_url).update(
        "foo_id",
        headers: { bar: "baz" },
        body: { bar: "wat" }
      )
      expect(response).to be_a(Dry::Monads::Success)
      expect(response.success).to be_a(
        Dryer::Clients::GeneratedClients::Response
      )
      expect(response.success.raw_response.body).to eq({ foo: "boo" }.to_json)
    end

    context "when part of the request does not match the provided contract" do
      it "returns a failure with an error message" do
        response = resource.new(base_url).update(
          "foo_id",
          body: { invalid: "payload" }
        )
        expect(response).to be_a(Dry::Monads::Failure)
        expect(response.failure).to be_a(StandardError)
      end
    end

    context "when part of the response does not match the provided contract" do

      let(:response) do
        instance_double(
          Net::HTTPResponse,
          code: 200,
          body: { grr: "boo" }.to_json
        )
      end

      it "returns a failure with an error message" do
        response = resource.new(base_url).update(
          "foo_id",
          body: { bar: "wat" }
        )
        expect(response).to be_a(Dry::Monads::Failure)
        expect(response.failure).to be_a(StandardError)
      end
    end
  end

  context "when making a request to a badly formed url" do
    let(:base_url) { "some garbage" }
    it "returns a failure" do
      response = resource.new(base_url).update(
        "foo_id",
        body: { bar: "wat" }
      )
      expect(response).to be_a(Dry::Monads::Failure)
      expect(response.failure).to be_a(StandardError)
    end
  end
end
