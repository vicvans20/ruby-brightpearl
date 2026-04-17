module Brightpearl
  # https://api-docs.brightpearl.com/accounting/customer-payment/index.html
  class CustomerPayment < Resource
    extend Brightpearl::APIOperations::Post
    extend Brightpearl::APIOperations::Delete

    attr_accessor :payment_id, :transaction_ref, :transaction_code, :payment_method_code,
                  :payment_type, :order_id, :currency_id, :currency_code,
                  :amount_authorized, :amount_paid, :expires, :payment_date,
                  :created_on, :journal_id

    class << self
      def resource_path
        "accounting-service/customer-payment"
      end

      # https://api-docs.brightpearl.com/accounting/customer-payment/post.html
      # https://api-docs.brightpearl.com/accounting/customer-payment/delete.html

      # https://api-docs.brightpearl.com/accounting/customer-payment/search.html
      def search(query_params = {})
        response = send_request(path: "accounting-service/customer-payment-search?#{to_query(query_params)}", method: :get)
        return response.merge({
          records: response[:payload]["response"]["results"].map { |item| CustomerPayment.new(item) },
        })
      end
    end

    # ARA => API Record Array
    def initialize(ara)
      @payment_id = ara[0]
      @transaction_ref = ara[1]
      @transaction_code = ara[2]
      @payment_method_code = ara[3]
      @payment_type = ara[4]
      @order_id = ara[5]
      @currency_id = ara[6]
      @currency_code = ara[7]
      @amount_authorized = ara[8]
      @amount_paid = ara[9]
      @expires = ara[10]
      @payment_date = ara[11]
      @created_on = ara[12]
      @journal_id = ara[13]
    end
  end
end
