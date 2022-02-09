# frozen_string_literal: true
RSpec.describe Brightpearl::ProductAvailability do
  let(:product_id) { 1007 }
  let(:product_id_2) { 1532 }

  describe "GET" do
    it "get availability of one product" do
      VCR.use_cassette("product_availability_get") do
        response = Brightpearl::ProductAvailability.get("#{product_id},#{product_id_2}")
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including(
              "#{product_id}" => a_hash_including( 
                "total" =>  a_hash_including(
                  "inStock" => be_truthy,
                  "onHand" => be_truthy,
                  "allocated" => be_truthy,
                  "inTransit" => be_truthy
                ), # total
                "warehouses" => be_truthy
              ), # product_id

              "#{product_id_2}" => a_hash_including( 
                "total" =>  a_hash_including(
                  "inStock" => be_truthy,
                  "onHand" => be_truthy,
                  "allocated" => be_truthy,
                  "inTransit" => be_truthy
                ), # total
                "warehouses" => be_truthy
              ), # product_id_2
            ) # hash of product_ids keys
          ), # payload
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

end