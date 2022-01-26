# frozen_string_literal: true
RSpec.describe Brightpearl::Order do
  let(:example_reference){ "#0001" }

  describe "GET" do

    it "returns one sale order" do
      VCR.use_cassette("order_get_one") do
        response = Brightpearl::Order.get(1)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 1, "orderTypeCode" => "SO") ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns multiple orders" do
      VCR.use_cassette("order_get_multiple") do
        response = Brightpearl::Order.get("1,320,321")
        expect(response).to include(
          payload: a_hash_including(
            "response" => include(
              a_hash_including("id" => 1,   "orderTypeCode" => "SO"),
              a_hash_including("id" => 320, "orderTypeCode" => "SO"),
              a_hash_including("id" => 321, "orderTypeCode" => "SO"),
            )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns one purchase order" do
      VCR.use_cassette("order_get_one_po") do
        response = Brightpearl::Order.get(312)
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 312, "orderTypeCode" => "PO") ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns empty response with unexisting id" do
      VCR.use_cassette("order_get_empty_not_found") do
        response = Brightpearl::Order.get(999)
        expect(response).to include(
          payload: a_hash_including(
            "response" => []
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns one order with custom fields" do
      VCR.use_cassette("order_get_one_with_custom_fields") do
        response = Brightpearl::Order.get(1, { includeOptional: "customFields" })
        expect(response).to include(
          payload: a_hash_including(
            "response" => [ a_hash_including("id" => 1, "orderTypeCode" => "SO", "customFields" => be_truthy) ]
          ),
          quota_remaining: be_truthy
        )
      end
    end

  end # GET

  describe "POST" do
    let(:post_body) {{ reference: example_reference,}}

    # For SO/SC
    let(:sale_params) do
      post_body.merge({
        orderTypeCode: "SO",
        parties: {
          customer: {
            contactId: 200
          }
        }
      })
    end
    # For PO/PC
    let(:purchase_params) do
      post_body.merge({
        orderTypeCode: "PO",
        parties: {
          supplier: {
            contactId: 418
          }
        }
      })
    end

    context "Success cases" do
      it "creates a SO" do
        VCR.use_cassette("order_post_so") do
          response = Brightpearl::Order.post(sale_params)
          expect(response).to include(
            payload: a_hash_including(
              "response" => be > 0
            ),
            quota_remaining: be_truthy
          )
        end
      end

      it "creates a SC" do
        VCR.use_cassette("order_post_sc") do
          sc_params = sale_params.merge({ "orderTypeCode" => "SC" })
          response = Brightpearl::Order.post(sc_params)
          expect(response).to include(
            payload: a_hash_including(
              "response" => be > 0
            ),
            quota_remaining: be_truthy
          )
        end
      end

      it "creaes a PO" do
        VCR.use_cassette("order_post_po") do
          response = Brightpearl::Order.post(purchase_params)
          expect(response).to include(
            payload: a_hash_including(
              "response" => be > 0
            ),
            quota_remaining: be_truthy
          )
        end
      end

      it "creates a PC" do
        VCR.use_cassette("order_post_pc") do
          pc_params = purchase_params.merge({ "orderTypeCode" => "PC" })
          response = Brightpearl::Order.post(pc_params)
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
      it "returns an error for unknown orderTypeCode" do
        VCR.use_cassette("order_post_error_unknown") do
          params = sale_params.merge({ orderTypeCode: "UK" })
          expect { Brightpearl::Order.post(params) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, code: "ORDC-006"))
        end
      end

      it "returns an error when parties doesn't correspond orderTypeCode" do
        VCR.use_cassette("order_post_error_wrong_party") do
          params = sale_params.merge({ orderTypeCode: "PO" }) # PO over sale params
          expect { Brightpearl::Order.post(params) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, code: "ORDC-022"))
        end
      end

      it "returns an error when missing required params" do
        VCR.use_cassette("order_post_error_missing_required") do
          expect { Brightpearl::Order.post(post_body) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, code: "ORDC-005"))
        end
      end

    end

  end # POST

  describe "SEARCH" do
    it "returns orders as expected" do
      VCR.use_cassette("order_search") do
        response = Brightpearl::Order.search(customerRef: example_reference)
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including("results" => be_truthy)
          ),
          records: include(
            (an_instance_of(described_class).and having_attributes(id: be_truthy, customer_ref: example_reference)),
            (an_instance_of(described_class).and having_attributes(id: be_truthy, customer_ref: example_reference)),
            (an_instance_of(described_class).and having_attributes(id: be_truthy, customer_ref: example_reference)),
            (an_instance_of(described_class).and having_attributes(id: be_truthy, customer_ref: example_reference)),
          ),
          quota_remaining: be_truthy
        )

        expect(response[:payload]["response"]["results"].size).to eq(response[:records].size)
      end
    end

    it "returns error for bad value" do
      VCR.use_cassette("order_search_bad_param") do
        expect { Brightpearl::Order.search(orderStatusId: "BAD PARAM") }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 500, code: "CMNC-018"))
      end
    end
  end # SEARCH

  describe "PATCH" do
    let(:create_params) {{ reference: example_reference, orderTypeCode: "SO", parties: { customer: { contactId: 200 } }}}
    let(:patch_params){[
      { "op": "replace", "path": "/delivery/deliveryDate", "value": "2022-01-20" },
      { "op": "replace", "path": "/reference", "value": "#XYZ" },
    ]}

    it "updates an order" do
      VCR.use_cassette("order_patch") do
        response = Brightpearl::Order.post(create_params)
        order_id = response[:payload]["response"]
        response = Brightpearl::Order.patch(order_id, patch_params)
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_hash_including( "acknowledged" => 0 )
          ),
          quota_remaining: be_truthy
        )
      end
    end

    it "returns an error when using invalid operation" do
      VCR.use_cassette("order_patch_error_operation") do
        response = Brightpearl::Order.post(create_params)
        order_id = response[:payload]["response"]
        expect { Brightpearl::Order.patch(order_id, [{ "op": "add", "path": "/reference", "value": "#XYZ" } ]) }.to raise_error(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 500, code: "CMNC-044") )
      end
    end
  end # PATCH

  describe "OPTIONS" do

    it "returns uris of requested orders" do
      VCR.use_cassette("order_options") do
        response = Brightpearl::Order.options("1-100,320,321")
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
