module Brightpearl
  class Resource

    def self.send_request(path:, method: :get, options: {})
      Brightpearl::Client.send_request(path: path, method: method, options: options)
    end

    def self.to_query(query_params)
      URI.encode_www_form(query_params)
    end

  end
end