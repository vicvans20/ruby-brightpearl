module Brightpearl
  # Webhooks are used to define a 'callback contract' between Brightpearl and some third-party system. They specify the circumstances under which Brightpearl should send an HTTP message to the third-party system and the format of that message.
  # 
  # They are typically used to notify a remote server supporting some integration of a change in the state of a resource in a customer's Brightpearl account. For example, a carrier integration will want to know when Goods-Out Notes are picked or packed.
  # 
  # Please read Brightpearl webhooks for more information on how and when to use webhooks.
  # https://api-docs.brightpearl.com/integration/webhook/index.html
  class Webhook < Resource
    extend Brightpearl::APIOperations::Get # /integration-service/webhook/{ID-SET}
    extend Brightpearl::APIOperations::Post # /integration-service/webhook
    extend Brightpearl::APIOperations::Delete # /integration-service/webhook/{ID}

    class << self
      def resource_path
        "integration-service/webhook"
      end
    end
  end
end