# frozen_string_literal: true
RSpec.describe Brightpearl::Currency do

  describe "SEARCH" do
    it "search all currencies" do
      VCR.use_cassette("currency_search") do
        response = Brightpearl::Currency.search
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including(
              "results" => be_an(Array),
              "metaData" => a_hash_including("resultsAvailable" => be_a(Integer))
            )
          ),
          records: include(
            an_object_having_attributes(
              id: be_a(Integer),
              code: be_a(String),
              symbol: be_a(String)
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "search currencies with query params" do
      VCR.use_cassette("currency_search_by_code") do
        response = Brightpearl::Currency.search(code: "USD")
        expect(response[:records].size).to eq(1)
        expect(response[:records].first).to have_attributes(
          code: "USD",
          title: be_a(String),
          symbol: be_a(String)
        )
        expect(response[:quota_remaining]).to be_truthy
      end
    end
  end # SEARCH

end
