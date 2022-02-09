# frozen_string_literal: true
RSpec.describe Brightpearl::TaxCode do

  describe "GET" do
    it "get tax codes" do
      VCR.use_cassette("tax_code_get") do
        response = Brightpearl::TaxCode.get
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy,
                "code" => be_truthy,
                "description" => be_truthy
              )
            )
          ), # payload
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"].size).to be > 1
      end
    end
    
    it "get specific tax code by id" do
      VCR.use_cassette("tax_code_get_by_id") do
        response = Brightpearl::TaxCode.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "id" => be_truthy,
                "code" => be_truthy,
                "description" => be_truthy
              )
            )
          ), # payload
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"].size).to eq(1)
      end
    end
  end # GET

end