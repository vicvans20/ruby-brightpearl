# frozen_string_literal: true
RSpec.describe Brightpearl::ContactTag do

  describe "GET" do
    it "get all contact tags" do
      VCR.use_cassette("contact_tag_get") do
        response = Brightpearl::ContactTag.get
        expect(response).to include(
          payload: a_hash_including(
            "response" => be_a(Hash)
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "get specific contact tag by id" do
      VCR.use_cassette("contact_tag_get_by_id") do
        response = Brightpearl::ContactTag.get(16)
        expect(response).to include(
          payload: a_hash_including(
            "response" => be_a(Hash)
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

end
