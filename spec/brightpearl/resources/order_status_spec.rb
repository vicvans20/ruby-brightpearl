# frozen_string_literal: true
RSpec.describe Brightpearl::OrderStatus do
  let(:post_params){{
    name: "TEST Status",
    orderTypeCode: "SO",
    color: "#60a0ff",
  }}

  describe "GET" do
    it "get status code requested" do
      VCR.use_cassette("order_status_get") do
        response = Brightpearl::OrderStatus.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including(
                "statusId" => be_truthy, "name" => be_truthy
              )
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

  describe "POST" do
    it "create a new status code" do
      VCR.use_cassette("order_status_post") do
        response = Brightpearl::OrderStatus.post(post_params)
        expect(response).to include(
          payload: a_hash_including(
            "response" => be_truthy
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # POST

end