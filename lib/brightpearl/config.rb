module Brightpearl
  class Config
    # Developer Account
    attr_accessor :dev_ref            # Developer ID
    attr_accessor :account            # Brightpearl account
    
    # Application specific
    attr_accessor :app_ref            # App ref
    attr_accessor :app_secret         # App secret
    attr_accessor :oauth_redirect_url # App authorized oauth redirect for app
    
    # Based on authentication process
    attr_accessor :token              # API token
    attr_accessor :api_domain         # API URL base. Depends on instance region. Obtained after auth process
    # attr_accessor :refresh_token
  end 
end 