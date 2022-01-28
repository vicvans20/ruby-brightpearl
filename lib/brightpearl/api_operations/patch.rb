module Brightpearl
  module APIOperations
    module Patch
      def patch(id, params)
        send_request(path: "#{resource_path}/#{id}", method: :patch, body: params)
      end
    end
  end
end