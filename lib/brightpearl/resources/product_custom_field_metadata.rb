module Brightpearl
  # https://api-docs.brightpearl.com/product/product-custom-field-metadata/get.html
  class ProductCustomFieldMetadata < Resource
    class << self
      def get(id_set = nil)
        path = "product-service/product/custom-field-meta-data"
        path = "#{path}/#{id_set}" if id_set

        send_request(path: path, method: :get)
      end
    end
  end
end
