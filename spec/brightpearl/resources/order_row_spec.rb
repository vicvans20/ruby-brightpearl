# frozen_string_literal: true
RSpec.describe Brightpearl::Order do
  let(:create_sale_order) do
    response = Brightpearl::Order.post({ 
      reference: "#0001", 
      orderTypeCode: "SO", 
      parties: { customer: { contactId: 200 } }
    })
    return response[:payload]["response"] # return SO ID
  end

  let(:post_params) {{
    # productId: bp_product["id"],
    productName: "Brightpearl Product",
    quantity: { magnitude: 5 },
    rowValue: {
      taxCode: "13",
      rowNet: { value: 100 },
      rowTax: { value: 13 },
    },
  }}

  describe "POST" do
    it "creates row as expected" do
      VCR.use_cassette("order_row_post") do
        order_id = create_sale_order
        response = Brightpearl::OrderRow.post(order_id, post_params)
        expect(response).to include(
          payload: a_hash_including(
            "response" => be > 0
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # POST

  describe "PATCH" do
    it "updates row as expected" do
      VCR.use_cassette("order_row_patch") do
        order_id = create_sale_order
        response = Brightpearl::OrderRow.post(order_id, post_params)
        row_id = response[:payload]["response"]

        response = Brightpearl::OrderRow.patch(order_id, row_id, [{
          op: "replace", path: "/rowValue/rowNet/value", value: 200,
        }])
        expect(response).to include(
          payload: a_hash_including( "response" => be_truthy )
        )
      end
    end
  end # PATCH

  describe "DELETE" do
    it "delete row as expected" do
      VCR.use_cassette("order_row_delete") do
        order_id = create_sale_order
        response = Brightpearl::OrderRow.post(order_id, post_params)
        row_id = response[:payload]["response"]

        response = Brightpearl::OrderRow.delete(order_id, row_id)
        expect(response).to include(
          payload: {}
        )
      end
    end
  end # DELETE

end