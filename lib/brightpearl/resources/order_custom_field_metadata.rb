module Brightpearl
  # https://api-docs.brightpearl.com/order/customfield-metadata/get.html
  class OrderCustomFieldMetadata < Resource
    VALID_ORDER_TYPES = ["sale", "purchase"].freeze

    class << self
      def get(order_type, id_set = nil)
        order_type = order_type.to_s
        validate_order_type!(order_type)

        path = "order-service/#{order_type}/custom-field-meta-data"
        path = "#{path}/#{id_set}" if id_set

        send_request(path: path, method: :get)
      end

      private

      def validate_order_type!(order_type)
        return if VALID_ORDER_TYPES.include?(order_type)

        raise ArgumentError, "Invalid order custom field metadata type: #{order_type.inspect}. Valid types: #{VALID_ORDER_TYPES.join(', ')}"
      end
    end
  end
end
