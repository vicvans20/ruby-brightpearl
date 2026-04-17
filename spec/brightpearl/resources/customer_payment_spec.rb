# frozen_string_literal: true

RSpec.describe Brightpearl::CustomerPayment do
  let(:sales_order) do
    {
      id: 1081505, # Test Order ID
      reference: "URP-TEST-XXX100",
    }
  end

  let(:receipt_params) do
    {
      transactionRef: "RUBY-BP-RECEIPT-REF-0001",
      transactionCode: "RUBY-BP-RECEIPT-CODE-0001",
      paymentMethodCode: "PUNTOS",
      paymentType: "RECEIPT",
      orderId: sales_order[:id],
      currencyIsoCode: "CRC",
      exchangeRate: 1.0,
      amountPaid: 100.00,
      paymentDate: "2026-04-17T10:00:00-06:00",
      journalRef: "ruby-brightpearl customer payment receipt test"
    }
  end

  it "POST, SEARCH, DELETE" do
    payment_id = nil

    # Create a customer payment
    VCR.use_cassette("customer_payment/post/receipt") do
      response = described_class.post(receipt_params)

      expect(response).to include(
        payload: a_hash_including(
          "response" => be > 0
        ),
        quota_remaining: be_truthy
      )

      payment_id = response[:payload]["response"]
    end

    # Find the customer payment
    VCR.use_cassette("customer_payment/search/simple_search") do
      response = described_class.search(orderId: sales_order[:id])

      expect(response).to include(
        payload: a_hash_including(
          "response" => a_hash_including("results" => be_truthy)
        ),
        records: include(
          an_instance_of(described_class).and having_attributes(
            payment_id: payment_id,
            order_id: sales_order[:id]
          )
        ),
        quota_remaining: be_truthy
      )

      expect(response[:records]).to all(be_a(described_class))
      expect(response[:payload]["response"]["results"].size).to eq(response[:records].size)
    end

    # Delete the customer payment
    VCR.use_cassette("customer_payment/delete/success") do
      response = described_class.delete(payment_id)

      expect(response).to include(
        payload: {},
        quota_remaining: be_truthy
      )
      # Verify the customer payment was deleted
      response = described_class.search(orderId: sales_order[:id])
  
      expect(response).to include(
        payload: a_hash_including(
          "response" => a_hash_including("results" => be_truthy)
        ),
        quota_remaining: be_truthy
      )
  
      expect(response[:records]).to all(be_a(described_class))
      expect(response[:records].map(&:payment_id)).not_to include(payment_id)
    end

  end
end
