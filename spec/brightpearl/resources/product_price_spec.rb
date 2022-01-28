# frozen_string_literal: true
RSpec.describe Brightpearl::ProductPrice do
  let(:product_id) { 1007 }

  describe "GET" do
    it "return error for product without prices" do
      VCR.use_cassette("product_price_get") do
        response = Brightpearl::ProductPrice.get(product_id)
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "productId" => be_truthy, "priceLists" => be_truthy              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "return error for not found product" do
      VCR.use_cassette("product_price_get_not_found") do
        expect { Brightpearl::ProductPrice.get(1) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 404, code: "CMNC-404") )
      end
    end
  end # GET

  describe "PUT" do
    let(:put_params){{
      priceLists: [
        {
          priceListId: 1,
          quantityPrice: {
            "1": 100,
            "5": 450,
          },
        },
      ]
    }}

    it "updates an product price" do
      VCR.use_cassette("product_price_put") do
        response = Brightpearl::ProductPrice.put(product_id, put_params)
        expect(response).to include(
          payload: {},
          quota_remaining: be_truthy
        )
      end
    end

  end # PUT

  describe "OPTIONS" do
    it "returns uris of requested products prices" do
      VCR.use_cassette("product_price_options") do
        response = Brightpearl::ProductPrice.options("1-100,320,321")
        expect(response).to include(
          payload: a_hash_including(
            "response" => {
              "getUris" => be_truthy
            }
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # options

end