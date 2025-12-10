# frozen_string_literal: true
RSpec.describe Brightpearl::ContactCustomField do
  let(:sample_contact_id) { 151499 }

  describe "GET" do
    it "returns a contact custom field" do
      VCR.use_cassette("customer/custom_field/get/simple_get") do
        response = Brightpearl::ContactCustomField.get(sample_contact_id)
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
        response = Brightpearl::ContactCustomField.patch(sample_contact_id, [
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

