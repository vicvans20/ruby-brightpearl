module Brightpearl
  # Goods-Out Notes are used to represent stock permanently leaving your stock control system. The most common use of a Goods-Out Note is to facilitate the fulfilment of a Sales Order.
  # 
  # When a Goods-Out Note is successfully created, stock is allocated to the specified Sales Order and is not available for the purposes of sales, Internal Transfers, External Transfers, Reservations or Stock Corrections.
  # 
  # Unlike the majority of resources that can be manipulated via the warehouse service, Goods-Out Notes have a temporal component, represented by lifecycle events.
  # 
  # A Goods-Out Note POST creates a Goods-Out Note with a created event, but for accounting and reporting purposes, the stock is still considered present in its original Warehouse and Locations
  # 
  # You should issue one or more Goods-Out Note Event POSTs to add lifecycle events such as picked, packed and shipped to the Goods-Note Out. The stock is not considered to have left a Warehouse until the shipped event is added to the Goods-Note Out.
  # 
  # A separate mechanism for creating a Goods-Out Note is provided by the External Transfer resource, which allows the movement of stock between two Warehouses
  # 
  # https://api-docs.brightpearl.com/warehouse/goods-out-note/index.html
  class GoodsOutNote < Resource
    class << self 
      # You may query for goods-out notes in several different ways:
      # * By goods-out note ID: `/order/*/goods-note/goods-out/4`
      # * By an ID set of goods-out note IDs: `/order/*/goods-note/goods-out/4-99,1,2`
      # * By an order ID: `/order/55/goods-note/goods-out/`
      # * By a set of order IDs: `/order/55-90,45/goods-note/goods-out/`
      # * By a combination of order IDs and goods-out note IDs: `/order/100-500/goods-note/goods-out/40-45`
      # https://api-docs.brightpearl.com/warehouse/goods-out-note/get.html
      def get(order_id_set:, gon_id_set: "")
        url = "warehouse-service/order/#{order_id_set}/goods-note/goods-out/#{gon_id_set}"
        send_request(path: url, method: :get)
      end
  
      # https://api-docs.brightpearl.com/warehouse/goods-out-note/post.html
      def post(order_id:, **params)
        url = "warehouse-service/order/#{order_id}/goods-note/goods-out"
        send_request(path: url, method: :post, body: params)
      end

      # https://api-docs.brightpearl.com/warehouse/goods-out-note/put.html
      def put(id:, **params)
        url = "warehouse-service/goods-note/goods-out/#{id}"
        send_request(path: url, method: :put, body: params)
      end
      
      # https://api-docs.brightpearl.com/warehouse/goods-out-note/delete.html
      def delete(order_id:, gon_id:)
        url = "warehouse-service/order/#{order_id}/goods-note/goods-out/#{gon_id}"
        send_request(path: url, method: :delete)
      end

      # search (TODO)
      # https://api-docs.brightpearl.com/warehouse/goods-out-note/search.html
    end

  end
end