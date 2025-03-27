# frozen_string_literal: true
RSpec.describe Brightpearl::OrderCustomField do
  describe "PATCH" do
    it "Add select list custom field value" do
      VCR.use_cassette("order/custom_field/patch") do
        response = Brightpearl::OrderCustomField.patch(516491, [
          {
            op: "add",
            path: "/PCF_REICUOTA",
            value: {
              "id": 137
            }
          }
        ])
        expect(response).to include(
          payload: a_hash_including( "response" => be_truthy )
        )
      end
    end
  end # PATCH

end