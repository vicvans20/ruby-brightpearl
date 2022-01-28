module Brightpearl
  module APIOperations
    module Post
      def post(params)
        send_request(path: "#{resource_path}", method: :post, body: params)
      end
    end
  end
end