# frozen_string_literal: true

require "brightpearl"
require "vcr"
require 'byebug'
require 'dotenv/load'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures"
  config.hook_into :webmock
  # config.before_record do |i|
  #   i.response.body.force_encoding('UTF-8')
  # end

  # Update the custom request matcher to be more flexible with domains
  config.register_request_matcher :brightpearl_uri_without_account do |request1, request2|
    uri1 = URI(request1.uri)
    uri2 = URI(request2.uri)
    
    # Only apply special matching to Brightpearl API URLs
    if uri1.host.include?('brightpearl') && uri2.host.include?('brightpearl')
      # Handle OAuth token URLs
      if uri1.path.start_with?('/token/') && uri2.path.start_with?('/token/')
        # For OAuth URLs like https://oauth.brightpearl.com/token/barulu
        # We want to ignore the account name after /token/
        path1_parts = uri1.path.split('/')
        path2_parts = uri2.path.split('/')
        
        # Replace the account name (index 2) with a placeholder
        if path1_parts.length > 2
          path1_parts[2] = 'ACCOUNT'
          path2_parts[2] = 'ACCOUNT'
        end
        
        # Compare with normalized paths - ignore the host completely
        path1_parts.join('/') == path2_parts.join('/')
      # Handle regular API URLs
      elsif uri1.path.include?('/public-api/') && uri2.path.include?('/public-api/')
        path1_parts = uri1.path.split('/')
        path2_parts = uri2.path.split('/')
        
        # Replace the account name (index 2) with a placeholder
        if path1_parts.length > 2 && path2_parts.length > 2
          path1_parts[2] = 'ACCOUNT'
          path2_parts[2] = 'ACCOUNT'
        end
        
        # Compare with normalized paths - ignore the host completely
        path1_parts.join('/') == path2_parts.join('/')
      else
        # For other Brightpearl URLs, ignore the host but compare the path
        uri1.path == uri2.path
      end
    else
      # For non-Brightpearl URLs, use standard URI comparison
      uri1 == uri2
    end
  end

  # Create a custom matcher for OAuth token requests that ignores specific body parameters
  config.register_request_matcher :oauth_body_without_credentials do |request1, request2|
    if request1.uri.include?('oauth.brightpearl.com/token') && request2.uri.include?('oauth.brightpearl.com/token')
      # For OAuth token requests, ignore client_id, client_secret, code, and redirect_uri
      body1 = CGI.parse(request1.body)
      body2 = CGI.parse(request2.body)
      
      # Only compare grant_type, which should be consistent
      body1['grant_type'] == body2['grant_type']
    else
      # For non-OAuth requests, use standard body comparison
      request1.body == request2.body
    end
  end

  # Instead of filtering the domain and account in the URI, let's just filter them in the response body
  # This way, the URI in the cassette remains valid for playback
  
  # Add a before_playback hook to replace the domain and account in the request URI
  config.before_playback do |interaction|
    # Replace <API_DOMAIN> with the actual domain from config
    if interaction.request.uri.include?('<API_DOMAIN>')
      interaction.request.uri.gsub!('<API_DOMAIN>', Brightpearl.config.api_domain)
    end
    
    # Replace <ACCOUNT> with the actual account from config
    if interaction.request.uri.include?('<ACCOUNT>')
      interaction.request.uri.gsub!('<ACCOUNT>', Brightpearl.config.account)
    end
  end
  
  # Add a before_record hook to sanitize sensitive data in the recorded cassette
  config.before_record do |interaction|
    # Sanitize the domain and account in the response body only
    if interaction.response.body
      interaction.response.body.gsub!(Brightpearl.config.api_domain, '<API_DOMAIN>') if Brightpearl.config.api_domain
      interaction.response.body.gsub!(Brightpearl.config.account, '<ACCOUNT>') if Brightpearl.config.account
    end
  end

  # Keep your existing filters for headers
  config.filter_sensitive_data('<APP-REF>') do |interaction|
    interaction.request.headers['Brightpearl-App-Ref'] && interaction.request.headers['Brightpearl-App-Ref'].first
  end

  config.filter_sensitive_data('<DEV-REF>') do |interaction|
    interaction.request.headers['Brightpearl-Dev-Ref'] && interaction.request.headers['Brightpearl-Dev-Ref'].first
  end

  config.filter_sensitive_data('<Bearer TOKEN>') do |interaction|
    interaction.request.headers['Authorization'] && interaction.request.headers['Authorization'].first
  end

  # Set default cassette options to use the custom matchers
  config.default_cassette_options = {
    match_requests_on: [:method, :brightpearl_uri_without_account]
  }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Brightpearl.config.api_domain = ENV["RUBY_BRIGHTPEARL_ENDPOINT"]
    Brightpearl.config.app_ref =      ENV["RUBY_BRIGHTPEARL_APP_REF"]
    Brightpearl.config.dev_ref =      ENV["RUBY_BRIGHTPEARL_DEV_REF"]
    Brightpearl.config.account =      ENV["RUBY_BRIGHTPEARL_ACCOUNT"]

    Brightpearl.config.token =        ENV["RUBY_BRIGHTPEARL_TOKEN"] # It expires

    Brightpearl.config.debug_mode =   true # Extra logs
  end
end
