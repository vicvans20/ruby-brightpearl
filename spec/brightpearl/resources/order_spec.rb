# frozen_string_literal: true
RSpec.describe Brightpearl::Order do
  describe "Get order" do

    it "returns one sale order" do
      VCR.use_cassette("order_get_one") do
        response = Brightpearl::Order.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 1, "orderTypeCode" => "SO") ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns multiple orders" do
      VCR.use_cassette("order_get_multiple") do
        response = Brightpearl::Order.get("1,320,321")
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including("id" => 1,   "orderTypeCode" => "SO"),
              a_hash_including("id" => 320, "orderTypeCode" => "SO"),
              a_hash_including("id" => 321, "orderTypeCode" => "SO"),
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns one purchase order" do
      VCR.use_cassette("order_get_one_po") do
        response = Brightpearl::Order.get(312)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 312, "orderTypeCode" => "PO") ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns empty response with unexisting id" do
      VCR.use_cassette("order_get_empty_not_found") do
        response = Brightpearl::Order.get(999)
        expect(response).to include(
          payload: a_hash_including(
            "response" => []
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns one order with custom fields" do
      VCR.use_cassette("order_get_one_with_custom_fields") do
        response = Brightpearl::Order.get(1, { includeOptional: "customFields" })
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 1, "orderTypeCode" => "SO", "customFields" => be_truthy) ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

  end # get order

end
