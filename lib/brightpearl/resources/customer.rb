module Brightpearl
  # https://api-docs.brightpearl.com/contact/contact/index.html
  class Customer < Resource
    extend Brightpearl::APIOperations::Get
    extend Brightpearl::APIOperations::Post
    extend Brightpearl::APIOperations::Patch
    extend Brightpearl::APIOperations::Options

    attr_accessor :id, :primary_email, :secondary_email, :tertiary_email,
                  :first_name, :last_name, :is_supplier, :company_name,
                  :is_staff, :is_customer, :created_on, :updated_on, :last_contacted_on,
                  :last_ordered_on, :nominal_code, :is_primary, :pri, :sec,
                  :mob, :exact_company_name, :title

    class << self
      def resource_path
        "contact-service/contact"
      end

      # https://api-docs.brightpearl.com/contact/contact/get.html
      # https://api-docs.brightpearl.com/contact/contact/post.html
      # https://api-docs.brightpearl.com/contact/contact/patch.html
      # https://api-docs.brightpearl.com/contact/contact/options.html
    
      # https://api-docs.brightpearl.com/contact/contact/search.html
      def search(query_params = {})
        response = send_request(path: "contact-service/contact-search?#{to_query(query_params)}", method: :get)
        return response.merge({ # modify final payload to set search results as objects
          records: response[:payload]["response"]["results"].map { |item| Customer.new(item) },
         })
      end
    end

    # ARA => API Record Array
    def initialize(ara)
      @id = ara[0]
      @primary_email = ara[1]
      @secondary_email = ara[2]
      @tertiary_email = ara[3]
      @first_name = ara[4]
      @last_name = ara[5]
      @is_supplier = ara[6]
      @company_name = ara[7]
      @is_staff = ara[8]
      @is_customer = ara[9]
      @created_on = ara[10]
      @updated_on = ara[11]
      @last_contacted_on = ara[12]
      @last_ordered_on = ara[13]
      @nominal_code = ara[14]
      @is_primary = ara[15]
      @pri = ara[16]
      @sec = ara[17]
      @mob = ara[18]
      @exact_company_name = ara[19]
      @title = ara[20]
    end

  end
end