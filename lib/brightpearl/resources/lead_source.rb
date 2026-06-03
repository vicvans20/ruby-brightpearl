module Brightpearl
  class LeadSource < Resource
    extend Brightpearl::APIOperations::Get
    class << self
      def resource_path
        "contact-service/lead-source"
      end

      def get(id_set = nil)
        if id_set
          super
        else
          super(nil)
        end
      end

      # https://api-docs.brightpearl.com/contact/lead-source/get.html

    end
  end
end
