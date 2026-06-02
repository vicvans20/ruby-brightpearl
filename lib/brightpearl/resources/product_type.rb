module Brightpearl
  class ProductType < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "product-service/product-type"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/product/product-type/get.html

    end
  end
end
