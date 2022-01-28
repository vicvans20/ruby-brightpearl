module Brightpearl
  module APIOperations
    module Put
      def put(id, params)
        send_request(path: "#{resource_path}/#{id}", method: :put, body: params)
      end
    end
  end
end