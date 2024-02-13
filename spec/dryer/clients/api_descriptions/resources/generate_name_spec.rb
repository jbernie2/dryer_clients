require_relative "../../../../../lib/dryer_clients.rb"

RSpec.describe Dryer::Clients::ApiDescriptions::Resources::GenerateName do

  let(:generated_name) { described_class.call(resource) }
  let(:simple_resource) do { url: "/foos" } end
  let(:multipart_resource) do { url: "/foos/bars" } end
  let(:resource_with_id) do { url: "/foos/:id" } end
  let(:multipart_resource_with_id) do { url: "/foos/:id/bars/:id" } end


  context "when given a simple resource path" do
    let(:resource) { simple_resource }
    it "returns a name similar to the path" do
      expect(generated_name).to eq("foos")
    end
  end

  context "when given a multipart resource path" do
    let(:resource) { multipart_resource }
    it "returns a name concatenating the parts with an underscore" do
      expect(generated_name).to eq("foos_bars")
    end
  end

  context "when given a resource path with ids" do
    let(:resource) { resource_with_id }
    it "removes the id parts of the path" do
      expect(generated_name).to eq("foos")
    end
  end

  context "when given a multipart resource path with ids" do
    let(:resource) { multipart_resource_with_id }
    it "removes the ids and returns a name concatenating the parts with an underscore" do
      expect(generated_name).to eq("foos_bars")
    end
  end
end
