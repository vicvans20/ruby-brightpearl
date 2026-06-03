# frozen_string_literal: true
RSpec.describe Brightpearl::NominalCode do

  describe "GET" do
    it "get all nominal codes" do
      VCR.use_cassette("nominal_code_get") do
        response = Brightpearl::NominalCode.get
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

    it "get specific nominal code by id" do
      VCR.use_cassette("nominal_code_get_by_id") do
        response = Brightpearl::NominalCode.get(1001)
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
