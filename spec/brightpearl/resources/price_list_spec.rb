# frozen_string_literal: true
RSpec.describe Brightpearl::PriceList do

  describe "GET" do
    it "get price list requested" do
      VCR.use_cassette("price_list_get") do
        response = Brightpearl::PriceList.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy, "name" => be_truthy, "currencyCode" => be_truthy, "currencySymbol" => be_truthy
              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

end