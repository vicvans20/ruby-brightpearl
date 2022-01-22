module Brightpearl
  class Config
    attr_accessor :api_url_base # API URL base. Depends on instance region
    attr_accessor :app_ref      # App ref
    attr_accessor :dev_ref      # Dev ref
    attr_accessor :account      # Brightpearl account
    # 
    attr_accessor :token
    # attr_accessor :refresh_token
  end 
end 