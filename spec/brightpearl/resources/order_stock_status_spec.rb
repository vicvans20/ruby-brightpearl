# frozen_string_literal: true
RSpec.describe Brightpearl::OrderStockStatus do

  describe "GET" do
    it "get all order stock statuses" do
      VCR.use_cassette("order_stock_status_get") do
        response = Brightpearl::OrderStockStatus.get
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy,
                "name" => be_truthy
              )
            )
          ),
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"].size).to be >= 1
      end
    end

    it "get specific order stock status by id" do
      VCR.use_cassette("order_stock_status_get_by_id") do
        response = Brightpearl::OrderStockStatus.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy,
                "name" => be_truthy
              )
            )
          ),
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"].size).to eq(1)
      end
    end
  end # GET

end
