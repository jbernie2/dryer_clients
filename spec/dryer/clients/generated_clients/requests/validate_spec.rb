require_relative "../../../../../lib/dryer_clients.rb"
require_relative "../../../../contracts/foo_create_request_contract.rb"
require_relative "../../../../contracts/foo_create_response_contract.rb"
require_relative "../../../../contracts/headers_contract.rb"
require_relative "../../../../contracts/url_parameters_contract.rb"

RSpec.describe Dryer::Clients::GeneratedClients::Requests::Validate do
  let(:validate) do
    described_class.call(
      path_variables: path_variables,
      headers: headers,
      body: body,
      url_parameters: url_parameters,
      request_contract: request_contract,
      headers_contract: headers_contract,
      url_parameters_contract: url_parameters_contract,
      url_parameters: url_parameters,
      path: path
    )
  end

  let(:path_variables) { [1,2] }
  let(:headers) { {important: "things"} }
  let(:body) { {bar: "baz"} }
  let(:url_parameters) { {query: "string"} }
  let(:url_parameters_contract) { Contracts::UrlParametersContract }
  let(:request_contract) { Contracts::FooCreateRequestContract }
  let(:headers_contract) { Contracts::HeadersContract }
  let(:path) { "foos/:id/bars/:id" }

  context "when the contract passes all validations" do
    it "returns a success" do
      expect(validate).to be_a(Dry::Monads::Success)
    end
  end

  context "when the number of path variables does not match the number in the url" do
    let(:path_variables) { [1,2,3] }
    it "returns a failure" do
      expect(validate).to be_a(Dry::Monads::Failure)
      expect(validate.failure).to be_a(StandardError)
    end
  end

  context "when the request headers fail validation" do
    let(:headers) { { ahhh: "something" } }
    it "returns a failure" do
      expect(validate).to be_a(Dry::Monads::Failure)
      expect(validate.failure).to be_a(StandardError)
    end
  end

  context "when the request body fails validation" do
    let(:body) { { ahhh: "something" } }
    it "returns a failure" do
      expect(validate).to be_a(Dry::Monads::Failure)
      expect(validate.failure).to be_a(StandardError)
    end
  end

  context "when the url parameters fail validation" do
    let(:url_parameters) { { ahhh: "something" } }
    it "returns a failure" do
      expect(validate).to be_a(Dry::Monads::Failure)
      expect(validate.failure).to be_a(StandardError)
    end
  end

  context "when there is no headers contract" do
    let(:headers) { { ahhh: "something" } }
    let(:headers_contract) { nil }

    it "skips validation for the headers" do
      expect(validate).to be_a(Dry::Monads::Success)
    end
  end

  context "when there is no request body contract" do
    let(:body) { { ahhh: "something" } }
    let(:request_contract) { nil }
    it "skips validation for the body" do
      expect(validate).to be_a(Dry::Monads::Success)
    end
  end

  context "when there is no url_parameters contract" do
    let(:url_parameters) { { ahhh: "something" } }
    let(:url_parameters_contract) { nil }
    it "skips validation for the url_parameters" do
      expect(validate).to be_a(Dry::Monads::Success)
    end
  end
end
