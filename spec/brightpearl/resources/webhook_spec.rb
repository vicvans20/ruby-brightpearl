# frozen_string_literal: true
RSpec.describe Brightpearl::Webhook do
  DEFAULT_HOOK_TEMPLATE = '{ "accountCode": "${account-code}", "resourceType": "${resource-type}", "id": "${resource-id}", "lifecycleEvent": "${lifecycle-event}", "fullEvent": "${full-event}", "raisedOn": "${raised-on}", "brightpearlVersion": "${brightpearl-version}" }'

  let(:placeholder_url) { "https://example.com/endpoint/to/receive/webhooks" }
  let(:webhook_params) do
    {
      subscribeTo: "goods-in-note.created",
      httpMethod: "POST",
      uriTemplate: placeholder_url,
      contentType: "application/json",
      idSetAccepted: true,
      qualityOfService: 1, # at-least-once
      bodyTemplate: DEFAULT_HOOK_TEMPLATE
    }
  end

  describe "POST" do
    it "creates a webhook" do
      VCR.use_cassette("webhook/post/create") do
        response = Brightpearl::Webhook.post(webhook_params)
        webhook_id = response[:payload]["response"]
        
        expect(response).to include(
          payload: a_hash_including(
            "response" => be > 0
          ),
          quota_remaining: be_truthy
        )

        # Clean up: delete the webhook
        Brightpearl::Webhook.delete(webhook_id)
      end
    end

    it "returns an error for invalid subsribe topic" do
      VCR.use_cassette("webhook/post/error_invalid_params") do
        invalid_params = webhook_params.merge({ subscribeTo: "invalid-resource" })
        expect { Brightpearl::Webhook.post(invalid_params) }.to raise_error(Brightpearl::RequestError, "INTC-064 - invalid-resource either does not exist or cannot be subscribed too")
      end
    end
  end # POST

  describe "GET" do
    it "returns a webhook" do
      VCR.use_cassette("webhook/get/single") do
        # Create a webhook first
        create_response = Brightpearl::Webhook.post(webhook_params)
        webhook_id = create_response[:payload]["response"]

        # Get the webhook
        response = Brightpearl::Webhook.get(webhook_id)
        expect(response).to include(
          payload: a_hash_including(
            "response" => a_collection_including(
              a_hash_including(
                "id" => webhook_id,
                "subscribeTo" => webhook_params[:subscribeTo],
                "uriTemplate" => webhook_params[:uriTemplate]
              )
            )
          ),
          quota_remaining: be_truthy
        )

        # Clean up: delete the webhook
        Brightpearl::Webhook.delete(webhook_id)
      end
    end

    it "returns error when getting non-existent webhook" do
      VCR.use_cassette("webhook/get/not_found") do
        expect { Brightpearl::Webhook.get(99999) }.to raise_error(Brightpearl::RequestError, "CMNC-404 - No webhooks available in ID Set 99999")
      end
    end
  end # GET

  describe "DELETE" do
    it "deletes a webhook" do
      VCR.use_cassette("webhook/delete/success") do
        # Create a webhook first
        create_response = Brightpearl::Webhook.post(webhook_params)
        webhook_id = create_response[:payload]["response"]

        # Delete the webhook
        response = Brightpearl::Webhook.delete(webhook_id)
        expect(response).to include(
          payload: {},
          quota_remaining: be_truthy
        )
      end
    end

    it "returns an error when deleting non-existent webhook" do
      VCR.use_cassette("webhook/delete/not_found") do
        expect { Brightpearl::Webhook.delete(99999) }.to raise_error(Brightpearl::RequestError, "CMNC-404 - Cannot find webhook: 99999")
      end
    end
  end # DELETE
end