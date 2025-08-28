# frozen_string_literal: true
RSpec.describe Brightpearl::CustomerCustomField do
  let(:sample_customer_id) { 151499 }

  describe "GET" do
    it "returns a customer custom field" do
      VCR.use_cassette("customer/custom_field/get/simple_get") do
        response = Brightpearl::CustomerCustomField.get(sample_customer_id)
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including(
              "PCF_CODAE" => 1234567890
            )
          )
        )
      end
    end
  end # GET

  describe "PATCH" do
    it "Add escalar custom field value" do
      VCR.use_cassette("customer/custom_field/patch/simple_patch") do
        response = Brightpearl::CustomerCustomField.patch(sample_customer_id, [
          {
            op: "add",
            path: "/PCF_CODAE",
            value: "1234567890"
          }
        ])
        expect(response).to include(
          payload: a_hash_including( 
            "response" => a_hash_including(
              "PCF_CODAE" => 1234567890
            )
          )
        )
      end
    end
  end # PATCH

end