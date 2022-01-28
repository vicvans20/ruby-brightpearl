module Brightpearl
  class Order < Resource
    extend Brightpearl::APIOperations::Get
    extend Brightpearl::APIOperations::Post
    extend Brightpearl::APIOperations::Patch
    extend Brightpearl::APIOperations::Options

    attr_accessor :id, :order_type_id, :contact_id, :order_status_id, :order_stock_status_id,
                  :created_on, :created_by_id,
                  :customer_ref, :order_payment_status_id, :updated_on,
                  :parent_order_id, :order_shipping_status_id, :external_ref,
                  :installed_integration_instance_id, :warehouse_id, :staff_owner_contact_id,
                  :tax_date, :department_id, :delivery_date

    class << self
      def resource_path
        "order-service/order"
      end

      # https://api-docs.brightpearl.com/order/order/get.html
      # https://api-docs.brightpearl.com/order/order/post.html
      # https://api-docs.brightpearl.com/order/order/patch.html
      # https://api-docs.brightpearl.com/order/order/options.html
    
  
      # https://api-docs.brightpearl.com/order/order/search.html
      def search(query_params = {})
        response = send_request(path: "order-service/order-search?#{to_query(query_params)}", method: :get)
        return response.merge({ # modify final payload to set search results as objects
          records: response[:payload]["response"]["results"].map { |item| Order.new(item) },
         })
      end
    end

    # DSL
    # ARA => API Record Array(from search and other endpoints)
    def initialize(ara, as_response: false)
      unless as_response
        @id = ara[0];
        @order_type_id = ara[1]; @contact_id = ara[2]; @order_status_id = ara[3]; @order_stock_status_id = ara[4];
        @created_on = ara[5]; @created_by_id = ara[6]; 
        @customer_ref = ara[7]; @order_payment_status_id = ara[8]; @updated_on = ara[9]; 
        @parent_order_id = ara[10]; @order_shipping_status_id = ara[11]; @external_ref = ara[12];
        @installed_integration_instance_id = ara[13]; @warehouse_id = ara[14]; @staff_owner_contact_id = ara[15]; 
        @tax_date = ara[16];
        @department_id = ara[17];
        @delivery_date = ara[18];
      else  # Order response from get_order
        @id = ara["id"]
        @order_type_id = nil 
        @contact_id = ara["parties"]["customer"]["contactId"]
        @order_status_id = ara["orderStatus"]["orderStatusId"]
        @order_stock_status_id = nil
        @created_on = ara["createdOn"]
        @created_by_id = ara["createdById"]
        @customer_ref = nil
        @order_payment_status_id = nil
        @updated_on = ara["updatedOn"]
        @parent_order_id = ara["parentOrderId"]
        @order_shipping_status_id = nil
        @external_ref = ara["reference"]
        @installed_integration_instance_id = nil
        @warehouse_id = ara["warehousrId"]
        @staff_owner_contact_id = ara["assignment"]["current"]["staffOwnerContactId"]
        @tax_date = ara["invoices"][0] && ara["invoices"][0]["taxDate"]
        @department_id = nil
        @delivery_date = nil
      end
    end

  end
end