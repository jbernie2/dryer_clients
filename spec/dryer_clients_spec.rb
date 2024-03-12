require_relative "../lib/dryer_clients.rb"
require_relative "./contracts/foo_create_request_contract.rb"
require_relative "./contracts/foo_create_response_contract.rb"
require_relative "./api_descriptions/test_api_description.rb"
require 'webmock/rspec'
require 'fileutils'
require 'debug'

RSpec.describe Dryer::Clients do
  let(:generate_client_gem) do
    described_class::Gems::Create.call(
      gem_name: gem_name,
      output_directory: output_dir,
      api_description_file: api_desc_file,
      api_description_class_name: TestApiDescription,
      contract_directory: contract_dir
    )
  end

  let(:gem_name) { "test_api" }
  let(:base_output_dir) { "spec/outputs" }
  let(:output_dir) { "#{base_output_dir}/#{gem_name}" }
  let(:contract_dir) { "spec/contracts" }
  let(:api_desc_file) { "spec/api_descriptions/test_api_description.rb" }
  let(:generated_gemspec_path) { "#{output_dir}/#{gem_name}.gemspec" }
  let(:generated_client_path) { "#{output_dir}/lib/#{gem_name}.rb" }
  let(:contract_output_path) { "#{output_dir}/lib/#{gem_name}/contracts" }

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
      FileUtils.rm_r(base_output_dir)
    end

    it "creates a gemspec file for the client" do
      expect(File).to exist(generated_gemspec_path)
    end

    it "outputs the generated client to the specified directory" do
      expect(File).to exist(generated_client_path)
    end

    it "outputs the contracts to the specified directory" do
      expect(File).to exist("#{contract_output_path}/foo_create_response_contract.rb")
      expect(File).to exist("#{contract_output_path}/foo_create_request_contract.rb")
    end

    it "returns path to created gem" do
      expect(generate_client_gem).to be(output_dir)
    end

    it "creates a client" do
      require_relative "../#{generate_client_gem}/lib/test_api.rb"
      expect(TestApi::Client.new("https://base.url").client).to be_a(Dryer::Clients::GeneratedClient)
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
