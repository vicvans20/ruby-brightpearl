module Brightpearl
  class OrderStatus < Resource

    class << self
      # https://api-docs.brightpearl.com/order/order-status/get.html
      def get(id_set)
        send_request(path: "order-service/order-status/#{id_set}", method: :get)
      end

      # https://api-docs.brightpearl.com/order/order-status/post.html
      def post(params)
        send_request(path: "order-service/order-status", method: :post, body: params)
      end

    end
  end
end