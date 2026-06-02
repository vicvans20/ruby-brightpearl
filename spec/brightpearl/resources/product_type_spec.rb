# frozen_string_literal: true
RSpec.describe Brightpearl::ProductType do

  describe "GET" do
    it "get all product types" do
      VCR.use_cassette("product_type_get") do
        response = Brightpearl::ProductType.get
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

    it "get specific product type by id" do
      VCR.use_cassette("product_type_get_by_id") do
        response = Brightpearl::ProductType.get(1)
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
