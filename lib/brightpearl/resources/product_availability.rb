module Brightpearl
  class ProductAvailability < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "warehouse-service/product-availability"
      end
      
      # https://api-docs.brightpearl.com/warehouse/product-availability/get.html

    end
  end
end