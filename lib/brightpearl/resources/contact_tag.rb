module Brightpearl
  class ContactTag < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "contact-service/tag"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/contact/tag/get.html

    end
  end
end
