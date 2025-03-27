module Brightpearl
  # Order custom fields are user-defined data held against an order. 
  # Custom fields are defined separately for sales and purchase orders. 
  # Field names and data types are shared between every order of the same type. Several data types are available.
  class OrderCustomField < Resource
    class << self 
      # https://api-docs.brightpearl.com/order/order-customfields/get.html
      def get(order_id)
        send_request(path: "order-service/order/#{order_id}/custom-field", method: :get)
      end
  
      # https://api-docs.brightpearl.com/order/order-customfields/patch.html
      def patch(order_id, params)
        send_request(path: "order-service/order/#{order_id}/custom-field", method: :patch, body: params)
      end
    end

  end
end