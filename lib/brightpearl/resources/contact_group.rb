module Brightpearl
  class ContactGroup < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "contact-service/contact-group"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/contact/contact-group/get.html

    end
  end
end
