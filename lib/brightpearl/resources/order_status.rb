module Brightpearl
  class OrderStatus < Resource
    extend Brightpearl::APIOperations::Get
    extend Brightpearl::APIOperations::Post
    class << self
      def resource_path
        "order-service/order-status"
      end

      # https://api-docs.brightpearl.com/order/order-status/get.html
      # https://api-docs.brightpearl.com/order/order-status/post.html

    end
  end
end