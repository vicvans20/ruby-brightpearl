module Brightpearl
  class Currency < Resource
    attr_accessor :id, :title, :code, :symbol, :exchange_rate, :is_default,
                  :exchange_rate_variance_nominal_code

    class << self
      # https://api-docs.brightpearl.com/accounting/currency/search.html
      def search(query_params = {})
        response = send_request(path: "accounting-service/currency-search?#{to_query(query_params)}", method: :get)
        response.merge({
          records: response[:payload]["response"]["results"].map { |item| Currency.new(item) }
        })
      end
    end

    # ARA => API Record Array
    def initialize(ara)
      @id                                    = ara[0]
      @title                                 = ara[1]
      @code                                  = ara[2]
      @symbol                                = ara[3]
      @exchange_rate                         = ara[4]
      @is_default                            = ara[5]
      @exchange_rate_variance_nominal_code   = ara[6]
    end
  end
end
