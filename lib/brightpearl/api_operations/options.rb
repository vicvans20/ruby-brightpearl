module Brightpearl
  module APIOperations
    module Options
      def options(id_set)
        send_request(path: "#{resource_path}/#{id_set}", method: :options)
      end
    end
  end
end