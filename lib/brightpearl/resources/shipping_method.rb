module Brightpearl
  class ShippingMethod < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "warehouse-service/shipping-method"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/warehouse/shipping-method/get.html

    end
  end
end
