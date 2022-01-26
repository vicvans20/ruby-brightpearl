module Brightpearl
  class Client
    def self.send_request(path:, method: :get, options: {} )
      headers = {
        "brightpearl-app-ref": "#{Brightpearl.config.app_ref}",
        "brightpearl-dev-ref": "#{Brightpearl.config.dev_ref}",
        "Authorization": "Bearer #{Brightpearl.config.token}"
      }

      url = "#{base_url}/#{path}"

      case method
      when :get
        response = HTTParty.get(url, headers: headers )
      when :delete
        response = HTTParty.delete(url, headers: headers)
      when :patch
        response = HTTParty.patch(url, 
          headers: headers.merge({ "Content-Type": "application/json" }), 
          body: options[:body].to_json,
        )
      when :put
        response = HTTParty.put(url, 
          headers: headers.merge({ "Content-Type": "application/json" }), 
          body: options[:body].to_json,
        )
      when :post
        response = HTTParty.post(url, 
          headers: headers.merge({ "Content-Type": "application/json" }), 
          body: options[:body].to_json,
        )
      else
        puts "Unrecognized http method"
      end

      puts url
      json = JSON.parse(response.body)

      if response.code == 503 # Unavailable MOST likeyly throttled
        raise Brightpearl::Throttled.new("Throttled", response: json, code: response.code)
      end
      if !!json["errors"]
        raise Brightpearl::RequestError.new("Request Error", code: response.code, response: response)
      end

      return { 
        payload: json, 
        quota_remaining: response.headers["brightpearl-requests-remaining"] 
      }
      
    end

    def self.base_url
      "https://#{Brightpearl.config.api_url_base}/public-api/#{Brightpearl.config.account}"; 
    end

  end
end