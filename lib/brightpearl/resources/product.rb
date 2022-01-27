module Brightpearl
  class Product < Resource
    attr_accessor :id, :product_name, :sku, :barcode,
                  :ean, :upc, :isbn, :mpn, 
                  :stock_tracked, :sales_channel_name, :created_on, :updated_on,
                  :bright_pearl_category_code, :product_group_id, :brand_id,
                  :product_type_id, :product_status, :primary_supplier_id

    class << self
      # https://api-docs.brightpearl.com/product/product/get.html
      def get(id_set, query_params = nil)
        url = "product-service/product/#{id_set}"
        url = "#{url}?#{to_query(query_params)}" if query_params
        send_request(path: url)
      end
  
      # https://api-docs.brightpearl.com/product/product/post.html
      def post(params)
        send_request(path: "product-service/product", method: :post, body: params)
      end
  
      # https://api-docs.brightpearl.com/product/product/put.html
      def put(id, params)
        send_request(path: "product-service/product/#{id}", method: :put, body: params)
      end

      # https://api-docs.brightpearl.com/product/product/options.html
      def options(id_set)
        send_request(path: "product-service/product/#{id_set}", method: :options)
      end
  
      # https://api-docs.brightpearl.com/product/product/search.html
      def search(query_params = {})
        response = send_request(path: "product-service/product-search?#{to_query(query_params)}", method: :get)
        return response.merge({ # modify final payload to set search results as objects
          records: response[:payload]["response"]["results"].map { |item| Product.new(item) },
         })
      end
    end

    # DSL
    # ARA => API Record Array
    def initialize(ara)
      @id = ara[0];
      @product_name = ara[1]; @sku = ara[2]; @barcode = ara[3];  
      @ean = ara[4]; @upc = ara[5]; @isbn = ara[6]; @mpn = ara[7];
      @stock_tracked = ara[8]; @sales_channel_name = ara[9];
      @created_on = ara[10]; @updated_on = ara[11];
      @bright_pearl_category_code = ara[12]; @product_group_id = ara[13];
      @brand_id = ara[14]; 
      @product_type_id = ara[15];
      @product_status = ara[16];
      @primary_supplier_id = ara[17];
    end

  end
end