module Brightpearl
  class PriceList < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "product-service/price-list"
      end
      
      # https://api-docs.brightpearl.com/product/price-list/get.html

    end
  end
end