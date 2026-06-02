module Brightpearl
  class Warehouse < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "warehouse-service/warehouse"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/warehouse/warehouse/get.html

    end
  end
end
