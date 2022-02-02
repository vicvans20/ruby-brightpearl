require 'spec_helper'

RSpec.describe Brightpearl::Auth do
  let(:redirect_uri){ "https://someplace/oauth/redirect.com" }

  it "generate url as expected" do
    account = "account_name"
    app_name = "app_name"

    Brightpearl.config.account = account
    Brightpearl.config.app_ref = app_name

    url = Brightpearl::Auth.oauth_url(state: "passcode", redirect_uri: redirect_uri)
    expect(url).to eq("https://oauth.brightpearl.com/authorize/#{account}?response_type=code&client_id=#{app_name}&redirect_uri=#{redirect_uri}&state=#{"passcode"}")
  end

  it "Exchange auth token for api token as expected" do
    VCR.use_cassette("auth_request_token") do
      Brightpearl.config.account = "barulu"

      response = Brightpearl::Auth.request_token(auth_token: "a4814ccf-5efa-4635-8ba5-8c47d562fcd8", redirect_uri: redirect_uri)
      expect(response).to include(
        token: be_truthy,
        refresh_token: be_truthy,
        api_domain: be_truthy
      )
    end
  end

end