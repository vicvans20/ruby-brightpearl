# frozen_string_literal: true
RSpec.describe Brightpearl::PaymentMethod do

  describe "GET" do
    it "get all payment methods" do
      VCR.use_cassette("payment_method_get") do
        response = Brightpearl::PaymentMethod.get
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

    it "get specific payment method by id" do
      VCR.use_cassette("payment_method_get_by_id") do
        response = Brightpearl::PaymentMethod.get(1)
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
