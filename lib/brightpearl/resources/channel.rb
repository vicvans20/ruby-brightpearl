module Brightpearl
  class Channel < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "product-service/channel"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/product/sales-channel/get.html

    end
  end
end
