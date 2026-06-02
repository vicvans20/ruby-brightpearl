# frozen_string_literal: true
RSpec.describe Brightpearl::ProductCategory do

  describe "GET" do
    it "get all product categories" do
      VCR.use_cassette("product_category_get") do
        response = Brightpearl::ProductCategory.get
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

    it "get specific product category by id" do
      VCR.use_cassette("product_category_get_by_id") do
        response = Brightpearl::ProductCategory.get(1)
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
