module Brightpearl
  class OrderShippingStatus < Resource

    class << self
      # https://api-docs.brightpearl.com/order/order-shipping-status/get.html
      def get
        send_request(path: "order-service/order-shipping-status", method: :get)
      end

    end
  end
end