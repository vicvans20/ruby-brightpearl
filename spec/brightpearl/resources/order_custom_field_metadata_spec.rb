# frozen_string_literal: true

RSpec.describe Brightpearl::OrderCustomFieldMetadata do
  let(:custom_field_id) { 131 }

  describe "GET" do
    it "returns sale order custom field metadata for a specific field" do
      VCR.use_cassette("order/custom_field_metadata/get/single") do
        response = described_class.get("sale", custom_field_id)
        metadata = response[:payload]["response"].find { |field| field["id"] == custom_field_id }

        expect(response[:quota_remaining]).to be_truthy
        expect(response[:payload]).to include("response" => be_an(Array))
        expect(metadata).to include(
          "id" => custom_field_id,
          "code" => "PCF_TIPONEG",
          "name" => "Tipo de Negocio",
          "customFieldType" => "SELECT",
          "required" => false
        )
      end
    end

    it "validates the order type" do
      expect {
        described_class.get("customer", custom_field_id)
      }.to raise_error(ArgumentError, /Invalid order custom field metadata type/)
    end
  end
end
