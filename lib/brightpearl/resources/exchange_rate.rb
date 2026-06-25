module Brightpearl
  class ExchangeRate < Resource
    class << self
      # https://api-docs.brightpearl.com/accounting/exchange-rate/get.html
      def get
        send_request(path: "accounting-service/exchange-rate/", method: :get)
      end

      # https://api-docs.brightpearl.com/accounting/exchange-rate/post.html
      def post(currency_id:, **params)
        send_request(path: "accounting-service/currency/#{currency_id}/exchange-rate", method: :post, body: params)
      end

      # https://api-docs.brightpearl.com/accounting/exchange-rate/put.html
      def put(currency_id:, **params)
        send_request(path: "accounting-service/currency/#{currency_id}/exchange-rate", method: :put, body: params)
      end
    end
  end
end
