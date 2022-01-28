module Brightpearl
  class OrderStatusUpdate < Resource

    class << self
      # https://api-docs.brightpearl.com/order/order-status-update/put.html
      def put(id, params)
        send_request(path: "order-service/order/#{id}/status", method: :put, body: params)
      end

    end
  end
end