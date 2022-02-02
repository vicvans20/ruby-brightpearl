require 'spec_helper'

RSpec.describe Brightpearl::Auth do
  let(:redirect_uri){ "https://someplace/oauth/redirect.com" }

  describe "oauth_url" do
    it "generate url as expected" do
      account = "account_name"
      app_name = "app_name"
  
      Brightpearl.config.account = account
      Brightpearl.config.app_ref = app_name
  
      url = Brightpearl::Auth.oauth_url(state: "passcode", redirect_uri: redirect_uri)
      expect(url).to eq("https://oauth.brightpearl.com/authorize/#{account}?response_type=code&client_id=#{app_name}&redirect_uri=#{redirect_uri}&state=#{"passcode"}")
    end
  end

  describe "auth_request_token" do
    it "Exchange auth token for api token as expected" do
      VCR.use_cassette("auth_request_token") do
        Brightpearl.config.account = "barulu"
  
        response = Brightpearl::Auth.request_token(auth_token: "a4814ccf-5efa-4635-8ba5-8c47d562fcd8", redirect_uri: redirect_uri)
        expect(response).to include(
          payload: be_truthy,
          data: {
            token: be_truthy,
            refresh_token: be_truthy,
            api_domain: be_truthy
          }
        )
      end
    end

    context "Failure cases" do # Pre-recorded with real data, later scuffed on the stored cassettes
      it "Fail with invalid client" do
        VCR.use_cassette("auth_request_token_error_invalid_client") do
          expect { Brightpearl::Auth.request_token(auth_token: "a4814ccf-5efa-4635-8ba5-8c47d562fcd8", redirect_uri: redirect_uri) }.to raise_exception(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, message: "invalid_client"))
        end
      end

      it "Fail with invalid client" do
        VCR.use_cassette("auth_request_token_error_redirect_uri_mismatch") do
          expect { Brightpearl::Auth.request_token(auth_token: "a4814ccf-5efa-4635-8ba5-8c47d562fcd8", redirect_uri: redirect_uri) }.to raise_exception(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, message: "Redirect uri does not match that used to request auth token"))
        end
      end

      it "Fail with invalid client" do
        VCR.use_cassette("auth_request_token_error_invalid_code") do
          expect { Brightpearl::Auth.request_token(auth_token: "a4814ccf-5efa-4635-8ba5-8c47d562fcd8", redirect_uri: redirect_uri) }.to raise_exception(an_instance_of(Brightpearl::RequestError).and having_attributes(status: 400, message: "The auth token has either expired or does not exist"))
        end
      end
    end # context
  end # auth_request_token


  

end