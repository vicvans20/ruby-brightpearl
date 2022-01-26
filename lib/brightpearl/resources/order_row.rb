module Brightpearl
  class OrderRow < Resource
    class << self 
      # https://api-docs.brightpearl.com/order/order-row/post.html
      def post(order_id, params)
        send_request(path: "order-service/order/#{order_id}/row", method: :post, body: params)
      end
  
      # https://api-docs.brightpearl.com/order/order-row/patch.html
      def patch(order_id, id, params)
        send_request(path: "order-service/order/#{order_id}/row/#{id}", method: :patch, body: params)
      end
      
      # https://api-docs.brightpearl.com/order/order-row/patch.html
      def delete(order_id, id)
        send_request(path: "order-service/order/#{order_id}/row/#{id}", method: :delete)
      end
    end

  end
end