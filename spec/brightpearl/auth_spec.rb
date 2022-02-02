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
  end # oauth_url

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
  end # request_token

  describe "use_refresh_token" do
    it "Refresh tokens as expected" do
      VCR.use_cassette("auth_use_refresh_token") do
        original_token = "NDdMW6Sx1koth7YLhmSWT3R1Q7PmT6SnFf6ihkpXw41I="
        original_refresh_token = "X1iEFfpSuQADO7895Y4eJDv42ZzIDvD0oOhHNIFM0Po="
        Brightpearl.config.account = "barulu"
        Brightpearl.config.app_ref = "appRef"
        Brightpearl.config.token = original_token
        Brightpearl.config.refresh_token = original_refresh_token

        response = Brightpearl::Auth.use_refresh_token() # Should automatically update the config.token and config.refresh_token
        expect(response).to include(
          payload: be_truthy,
          data: { token: be_truthy, refresh_token: be_truthy, api_domain: be_truthy }
        )
        expect(Brightpearl.config.token).not_to eq( original_token )
        expect(Brightpearl.config.refresh_token).not_to eq( original_refresh_token )
      end
    end
  end # use_refresh_token
  

end