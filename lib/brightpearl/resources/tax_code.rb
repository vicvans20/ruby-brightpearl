module Brightpearl
  class TaxCode < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "accounting-service/tax-code"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end
      
      # https://api-docs.brightpearl.com/accounting/tax-code/get.html

    end
  end
end