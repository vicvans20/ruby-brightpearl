module Brightpearl
  class Auth
    def self.oauth_url(state:, redirect_uri:)
      "https://oauth.brightpearl.com/authorize/#{Brightpearl.config.account}?response_type=code&client_id=#{Brightpearl.config.app_ref}&redirect_uri=#{redirect_uri}&state=#{state}"
    end

    def self.request_token(auth_token:, redirect_uri:)
      token_endpoint = "https://oauth.brightpearl.com/token/#{Brightpearl.config.account}"
      body = {
        grant_type: "authorization_code",
        code: auth_token,
        client_id: Brightpearl.config.app_ref,
        client_secret: Brightpearl.config.app_secret,
        redirect_uri: redirect_uri, # SAME AS THE ONE USED ON oauth_url
      }

      response = HTTParty.post(token_endpoint, 
        body: body,
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'charset' => 'utf-8'
        }
      )
      json = JSON.parse(response.body)
      raise Brightpearl::RequestError.new(json["error_description"] || json["error"], response: json, status: 400) if response.code == 400

      return {
        payload: json,
        data: {
          token: json["access_token"],
          refresh_token: json["refresh_token"],
          api_domain: json["api_domain"],
        }
      }
    end

    def self.use_refresh_token(refresh_token: nil, autoupdate: true)
      token_endpoint = "https://oauth.brightpearl.com/token/#{Brightpearl.config.account}"
      rtoken = refresh_token || Brightpearl.config.refresh_token
      body = {
        grant_type: "refresh_token",
        refresh_token: rtoken,
        client_id: Brightpearl.config.app_ref,
      }
      response = HTTParty.post(token_endpoint, 
        body: body,
        headers: { "Content-Type": "application/x-www-form-urlencoded", 'charset' => 'utf-8' }
      )

      json = JSON.parse(response.body)
      if json["access_token"] && autoupdate
        Brightpearl.config.token = json["access_token"]
        Brightpearl.config.refresh_token = json["refresh_token"]
      end

      return {
        payload: json,
        data: {
          token: json["access_token"],
          refresh_token: json["refresh_token"],
          api_domain: json["api_domain"]
        }
      }

    end

  end
end