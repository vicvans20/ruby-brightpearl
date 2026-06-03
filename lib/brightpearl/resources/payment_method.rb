module Brightpearl
  class PaymentMethod < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "accounting-service/payment-method"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/accounting/payment-method/get.html

    end
  end
end
