# frozen_string_literal: true
RSpec.describe Brightpearl::GoodsOutNote do
  let(:sample_gon) do
    {
      order_id: 988116,
      gon_id: 12447605
    }
  end

  describe "GET" do
    it "Get all goods-out notes for an order" do
      VCR.use_cassette("goods_out_note/get/all_for_order") do
        response = Brightpearl::GoodsOutNote.get(order_id_set: sample_gon[:order_id])
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including(
              sample_gon[:gon_id].to_s => a_hash_including(
                "status" => be_truthy,
                "shipping" => be_truthy,
                "createdOn" => be_a(String),
              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "Get a specific goods-out note" do
      VCR.use_cassette("goods_out_note/get/by_gon_id") do
        response = Brightpearl::GoodsOutNote.get(order_id_set: "*", gon_id_set: sample_gon[:gon_id])
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_collection_including(
              sample_gon[:gon_id].to_s => a_hash_including(
                "status" => be_truthy,
                "shipping" => be_truthy,
                "createdOn" => be_a(String),
              )
            )
          ),
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"].size).to eq(1)
      end
    end
  end

  xdescribe "POST" do
  end

  xdescribe "PUT" do
  end

  xdescribe "DELETE" do
  end

  xdescribe "SEARCH" do
  end
end