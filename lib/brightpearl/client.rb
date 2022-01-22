module Brightpearl
  class Client
    def self.send_request(path:, verb: :get, options: {} )
      headers = {
        "brightpearl-app-ref": "#{Brightpearl.config.app_ref}",
        "brightpearl-dev-ref": "#{Brightpearl.config.dev_ref}",
        "Authorization": "Bearer #{Brightpearl.config.token}"
      }

      url = "#{base_url}/#{path}"

      case verb
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

      puts headers
      puts url
      json = JSON.parse(response.body)

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