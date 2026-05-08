module Brightpearl
  # https://api-docs.brightpearl.com/contact/custom-field-meta-data/get.html
  class ContactCustomFieldMetadata < Resource
    VALID_CONTACT_TYPES = ["customer", "supplier"].freeze

    class << self
      def get(contact_type, id_set = nil)
        contact_type = contact_type.to_s
        validate_contact_type!(contact_type)

        path = "contact-service/#{contact_type}/custom-field-meta-data"
        path = "#{path}/#{id_set}" if id_set

        send_request(path: path, method: :get)
      end

      private

      def validate_contact_type!(contact_type)
        return if VALID_CONTACT_TYPES.include?(contact_type)

        raise ArgumentError, "Invalid contact custom field metadata type: #{contact_type.inspect}. Valid types: #{VALID_CONTACT_TYPES.join(', ')}"
      end
    end
  end
end
