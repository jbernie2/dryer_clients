require_relative "../lib/dryer_clients.rb"
require_relative "./contracts/foo_create_request_contract.rb"
require_relative "./contracts/foo_create_response_contract.rb"
require 'webmock/rspec'
require 'fileutils'

RSpec.describe Dryer::Clients do
  let(:generate_client_gem) do
    described_class::Gems::Create.call(
      api_description: api_desc,
      gem_name: gem_name,
      output_directory: output_dir,
      contract_directory: contract_dir
    )
  end

  let(:gem_name) { "test_api" }
  let(:output_dir) { "spec/outputs/#{gem_name}" }
  let(:contract_dir) { "spec/contracts" }
  let(:generated_gemspec_path) { "#{output_dir}/#{gem_name}.gemspec" }

  let(:client) do 
    described_class::Create
      .call(api_desc)
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


  context "when generating a gem for the client" do
    before do
      generate_client_gem
    end

    after do
      FileUtils.rm_r(output_dir)
    end

    it "creates a gemspec file for the client" do
      expect(File).to exist(generated_gemspec_path)
    end

    it "outputs the generated client to the specified directory" do
      expect(File).to exist(generated_client_path)
    end

    it "outputs the contracts to the specified directory" do
      expect(File).to exist(contract_output_path)
    end

    it "returns a reference to the generated client class" do
      expect(generate_client_gem).to be_a(Dryer::Clients::GeneratedClient)
    end
  end

  context "when generating the client" do
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

    it "builds a client for api" do
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
