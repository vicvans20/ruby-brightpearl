module Brightpearl
  # Contact custom fields are the user-defined data held against Brightpearl contacts. Several data types are available. Custom fields are separated between Supplier contacts and Customer contacts, and may only be assigned to one of these groups.
  # https://api-docs.brightpearl.com/contact/custom-field/index.html
  class CustomerCustomField < Resource
    class << self 
      # https://api-docs.brightpearl.com/contact/custom-field/get.html
      def get(contact_id)
        send_request(path: "contact-service/contact/#{contact_id}/custom-field", method: :get)
      end
  
      # https://api-docs.brightpearl.com/contact/custom-field/patch.html
      def patch(contact_id, params)
        send_request(path: "contact-service/contact/#{contact_id}/custom-field", method: :patch, body: params)
      end
    end

  end
end