# frozen_string_literal: true
RSpec.describe Brightpearl::ExchangeRate do

  describe "GET" do
    it "get all exchange rates" do
      VCR.use_cassette("exchange_rate_get") do
        response = Brightpearl::ExchangeRate.get
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "currencyId" => be_truthy,
                "rateActiveFrom" => be_a(String),
                "rate" => be_a(Numeric)
              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

  describe "POST" do
    it "create a new exchange rate for a currency" do
      VCR.use_cassette("exchange_rate_post") do
        response = Brightpearl::ExchangeRate.post(
          currency_id: 2,
          rateActiveFrom: "2026-06-25",
          rate: 1.234567
        )
        expect(response).to include(
          payload: a_hash_including(
            "response" => be_a(Integer)
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # POST

  describe "PUT" do
    it "update the initial exchange rate for a currency" do
      VCR.use_cassette("exchange_rate_put") do
        response = Brightpearl::ExchangeRate.put(
          currency_id: 2,
          rateActiveFrom: "2026-06-25",
          rate: 1.250000
        )
        expect(response).to include(
          payload: a_hash_including(
            "response" => be_a(Integer)
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # PUT

end
