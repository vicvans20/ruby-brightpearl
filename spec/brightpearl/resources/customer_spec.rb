# frozen_string_literal: true
RSpec.describe Brightpearl::Customer do
  let(:sample_customer_id) { 151499 }
  let(:sample_customer_id2) { 81011 }

  describe "GET" do

    it "returns one customer" do
      VCR.use_cassette("customer/get/simple_get") do
        response = Brightpearl::Customer.get(sample_customer_id)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ 
              a_hash_including("contactId" => sample_customer_id) 
            ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns multiple customers" do
      VCR.use_cassette("customer/get/multiple_get") do
        response = Brightpearl::Customer.get("#{sample_customer_id2},#{sample_customer_id}")
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including("contactId" => sample_customer_id),
              a_hash_including("contactId" => sample_customer_id2)
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    # {"errors": [ { "code": "CMNC-404", "message": "No Contact Found" } ] }
    it "returns an error when the customer does not exist" do
      VCR.use_cassette("customer/get/empty_not_found") do
        expect {
          Brightpearl::Customer.get(1)
        }.to raise_error(Brightpearl::RequestError, "CMNC-404 - No Contact Found")
      end
    end

  end # GET

  # Requires Address resource as Customer creation requires address ID to work
  xdescribe "POST" do
    let(:post_body) do
      {
        firstName: "John",
        lastName: "Doe",
        communication: {
          emails: {
            PRI: {
              email: "john.doe.lib@example.com"
            }
          }
        },
      }
    end

    context "Success cases" do
      it "creates a customer" do
        VCR.use_cassette("customer/post/simple_post") do
          response = Brightpearl::Customer.post(post_body)
          expect(response).to include(
            payload: a_hash_including(
              "response" => be_truthy
            ),
            quota_remaining: be_truthy
          )
        end
      end
    end

    context "Error cases" do
      it "returns error for missing required fields" do
        VCR.use_cassette("customer/post/error_missing_required") do
          response = Brightpearl::Customer.post({})
          expect(response).to include(
            payload: a_hash_including(
              "errors" => be_truthy
            ),
            quota_remaining: be_truthy
          )
        end
      end
    end

  end # POST

  describe "PATCH" do
    let(:patch_body) do
      [
        {
          op: "replace",
          path: "/firstName",
          value: "Jane"
        },
        {
          op: "replace",
          path: "/lastName",
          value: "Smith"
        }
      ]
    end

    it "updates a customer" do
      VCR.use_cassette("customer/patch/simple_patch") do
        response = Brightpearl::Customer.patch(sample_customer_id, patch_body)
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including(
              "firstName" => "Jane",
              "lastName" => "Smith"
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

  end # PATCH

  describe "OPTIONS" do
    it "returns customer options" do
      VCR.use_cassette("customer/options/simple_options") do
        response = Brightpearl::Customer.options("#{sample_customer_id2},#{sample_customer_id}")
        expect(response).to include(
          payload: be_truthy,
          quota_remaining: be_truthy
        )
      end
    end

  end # OPTIONS

  describe "SEARCH" do
    it "searches customers" do
      VCR.use_cassette("customer/search/simple_search") do
        response = Brightpearl::Customer.search({ primaryEmail: "foo@business.com" })
        expect(response).to include(
          records: be_an(Array),
          payload: a_hash_including(
            "response" => a_hash_including(
              "results" => be_an(Array)
            )
          ),
          quota_remaining: be_truthy
        )

        expect(response[:records]).to all(be_a(Brightpearl::Customer))
        expect(response[:records].first.primary_email).to eq("foo@business.com")
      end
    end
  end # SEARCH
end 