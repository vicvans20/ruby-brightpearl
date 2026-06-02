module Brightpearl
  class ProductCategory < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "product-service/brightpearl-category"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/product/category/get.html

    end
  end
end
