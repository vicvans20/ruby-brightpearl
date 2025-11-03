module Brightpearl
  module APIOperations
    module Delete
      def delete(id)
        send_request(path: "#{resource_path}/#{id}", method: :delete)
      end
    end
  end
end