# frozen_string_literal: true
RSpec.describe Brightpearl::Product do
  let(:example_product_id){ 1007 }
  let(:example_product_ids){ [1007, 1532, 1569] }
  let(:post_params){{
    brandId: 74,
    financialDetails: {
      taxable: true,
      taxCode: { id: 2, code: "T" }
    },
    salesChannels: [{
      salesChannelName: "Brightpearl",
      productName: "Test Product",
      categories: [{
        categoryCode: 296,
      }]
    }]
  }}

  describe "GET" do
    it "returns one product" do
      VCR.use_cassette("product_get_one") do
        response = Brightpearl::Product.get(example_product_id)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => example_product_id, "identity" => be_truthy, "stock" => be_truthy) ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns multiple products" do
      VCR.use_cassette("product_get_multiple") do
        response = Brightpearl::Product.get(example_product_ids.join(","))
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including("id" => example_product_ids[0] ),
              a_hash_including("id" => example_product_ids[1] ),
              a_hash_including("id" => example_product_ids[2] ),
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns one product with custom fields" do
      VCR.use_cassette("product_get_one_with_custom_fields") do
        response = Brightpearl::Product.get(example_product_id, { includeOptional: "customFields" })
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => example_product_id, "customFields" => be_truthy) ]
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # GET

  describe "POST" do
    context "Success cases" do
      it "creates a product" do
        VCR.use_cassette("product_post") do
          response = Brightpearl::Product.post(post_params)
          expect(response).to include(
            payload: a_hash_including(
              "response" => be > 0
            ),
            quota_remaining: be_truthy
          )
        end
      end
    end # Success cases

    context "Failure cases" do
      it "returns an error when missing required params" do
        VCR.use_cassette("product_post_error_missing_required") do
          params = post_params.merge({ brandId: nil })
          expect { Brightpearl::Product.post(params) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, code: "PRDC-014"))
        end
      end
    end

  end # POST

  describe "SEARCH" do
    it "returns products as expected" do
      VCR.use_cassette("product_search") do
        response = Brightpearl::Product.search(productName: "Test Product")
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including("results" => be_truthy)
          ),
          records: include(
            (an_instance_of(described_class).and having_attributes(id: be_truthy, product_name: "Test Product")),
          ),
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"]["results"].size).to eq(response[:records].size)
      end
    end

    it "returns error for bad value" do
      VCR.use_cassette("product_search_bad_param") do
        expect { Brightpearl::Product.search(productId: "BAD PARAM") }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 500, code: "CMNC-018"))
      end
    end
  end # SEARCH

  describe "PUT" do
    let(:put_params){{
      salesChannels: [{
        salesChannelName: "Brightpearl",
        productName: "Test Product Updated!",
      }]
    }}
    it "updates an product" do
      VCR.use_cassette("product_put") do
        response = Brightpearl::Product.post(post_params)
        id = response[:payload]["response"]
        response = Brightpearl::Product.put(id, put_params)
        expect(response).to include(
          payload: {},
          quota_remaining: be_truthy
        )
      end
    end

    xit "returns an error when using invalid operation" do
      VCR.use_cassette("product_put_error_operation") do
        # TODO
      end
    end
  end # PATCH

  describe "OPTIONS" do
    it "returns uris of requested products" do
      VCR.use_cassette("product_options") do
        response = Brightpearl::Product.options("1-100,320,321")
        expect(response).to include(
          payload: a_hash_including(
            "response" => {
              "getUris" => be_truthy
            }
          ),
          quota_remaining: be_truthy
        )
      end
    end
  end # OPTIONS

end
