# frozen_string_literal: true
RSpec.describe Brightpearl::OrderShippingStatus do

  describe "GET" do
    it "get shipping status codes" do
      VCR.use_cassette("order_shipping_status_get") do
        response = Brightpearl::OrderShippingStatus.get()
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy, "code" => be_truthy, "description" => be_truthy
              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # POST

end