module Brightpearl
  class Auth
    def self.oauth_url(state)
      "https://oauth.brightpearl.com/authorize/#{Brightpearl.config.account}?response_type=code&client_id=#{Brightpearl.config.app_ref}&redirect_uri=#{Brightpearl.config.oauth_redirect_url}&state=#{state}"
    end

    def self.request_token(auth_token)
      token_endpoint = "https://oauth.brightpearl.com/token/#{Brightpearl.config.account}"
      body = {
        grant_type: "authorization_code",
        code: auth_token,
        client_id: Brightpearl.config.app_ref,
        client_secret: Brightpearl.config.app_secret,
        redirect_uri: Brightpearl.config.oauth_redirect_url
      }

      response = HTTParty.post(token_endpoint, 
        body: body,
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        }
      )
      data = JSON.parse(response.body)

      return {
        token: data["access_token"],
        refresh_token: data["refresh_token"],
        api_domain: data["api_domain"],
      }
    end
  end
end