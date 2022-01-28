module Brightpearl
  class PriceList < Resource

    class << self
      # https://api-docs.brightpearl.com/product/price-list/get.html
      def get(id)
        send_request(path: "product-service/price-list/#{id}", method: :get)
      end

    end
  end
end