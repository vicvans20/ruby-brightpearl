module Brightpearl
  class ProductPrice < Resource
    class << self 
      # https://api-docs.brightpearl.com/product/product-price/get.html
      def get(product_idset, price_list_idset = nil)
        path = "product-service/product-price/#{product_idset}"
        path = "#{path}/price-list/#{price_list_id}" if price_list_idset
        send_request(path: path, method: :get)
      end
  
      # https://api-docs.brightpearl.com/product/product-price/put.html
      def put(product_id, params)
        send_request(path: "product-service/product-price/#{product_id}/price-list", method: :put, body: params)
      end
      
      # https://api-docs.brightpearl.com/product/product-price/options.html
      def options(product_idset, price_list_idset = nil)
        path = "product-service/product-price/#{product_idset}"
        path = "#{path}/price-list/#{price_list_id}" if price_list_idset
        send_request(path: path, method: :options)
      end
    end

  end
end