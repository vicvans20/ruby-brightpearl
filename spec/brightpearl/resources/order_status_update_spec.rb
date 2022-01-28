# frozen_string_literal: true
RSpec.describe Brightpearl::OrderStatusUpdate do
  let(:create_sale_order) do
    response = Brightpearl::Order.post({ 
      reference: "#0001", 
      orderTypeCode: "SO", 
      parties: { customer: { contactId: 200 } }
    })
    return response[:payload]["response"] # return SO ID
  end
  let(:update_params){{
    "orderStatusId": 2
  }}

  describe "PUT" do
    it "updates the status of an order" do
      VCR.use_cassette("order_status_update_put") do
        order_id = create_sale_order
        response = Brightpearl::OrderStatusUpdate.put(order_id, update_params)
        expect(response).to include(
          payload: {},
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

end