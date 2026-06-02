module Brightpearl
  class Brand < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "product-service/brand"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/product/brand/get.html

    end
  end
end
