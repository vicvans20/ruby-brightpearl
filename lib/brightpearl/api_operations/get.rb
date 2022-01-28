module Brightpearl
  module APIOperations
    module Get
      def get(id_set, query_params = nil)
        path = "#{resource_path}/#{id_set}"
        path = "#{path}?#{to_query(query_params)}" if query_params
        send_request(path: path, method: :get)
      end
    end
  end
end