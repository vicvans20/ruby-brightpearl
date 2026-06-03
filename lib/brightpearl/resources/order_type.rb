module Brightpearl
  class OrderType < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "order-service/order-type"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/order/order-type/get.html

    end
  end
end
