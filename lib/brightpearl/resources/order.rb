module Brightpearl
  class Order
    def self.send_request(path:, verb: :get, options: {})
      Brightpearl::Client.send_request(path: path, verb: verb, options: options)
    end

    def self.get(id_set, query_params = nil)
      url = "order-service/order/#{id_set}"
      url = "#{url}?#{URI.encode_www_form(query_params)}" if query_params
      send_request(path: url)
    end

  end
end