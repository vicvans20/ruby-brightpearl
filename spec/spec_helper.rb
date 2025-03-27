# frozen_string_literal: true

require "brightpearl"
require "vcr"
require 'byebug'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures"
  config.hook_into :webmock
  # config.before_record do |i|
  #   i.response.body.force_encoding('UTF-8')
  # end

  # Add custom request matcher for Brightpearl URLs
  config.register_request_matcher :brightpearl_uri_without_account do |request1, request2|
    uri1 = URI(request1.uri)
    uri2 = URI(request2.uri)
    
    # Only apply special matching to Brightpearl API URLs
    # This way URL matcher will ignore RUBY_BRIGHTPEARL_ENDPOINT and RUBY_BRIGHTPEARL_ACCOUNT
    # i.e. These 2 will be equivalent:
    # https://eu-use.brightpearl.com/public-api/barulu/order-service/order
    # https://ws-use.brightpearl.com/public-api/unimart/order-service/order
    if uri1.host.include?('brightpearl.com') && uri2.host.include?('brightpearl.com')
      path1_parts = uri1.path.split('/')
      path2_parts = uri2.path.split('/')
      
      # Replace the account name (index 2) with a placeholder
      if path1_parts.length > 2 && path2_parts.length > 2
        path1_parts[2] = 'ACCOUNT'
        path2_parts[2] = 'ACCOUNT'
      end
      
      # Compare with normalized paths
      uri1.host == uri2.host && path1_parts.join('/') == path2_parts.join('/')
    else
      # For non-Brightpearl URLs, use standard URI comparison
      uri1 == uri2
    end
  end

  # Set default cassette options to use the custom matcher
  config.default_cassette_options = {
    match_requests_on: [:method, :brightpearl_uri_without_account, :body]
  }

  config.filter_sensitive_data('<APP-REF>') do |interaction|
    interaction.request.headers['Brightpearl-App-Ref'] && interaction.request.headers['Brightpearl-App-Ref'].first
  end

  config.filter_sensitive_data('<DEV-REF>') do |interaction|
    interaction.request.headers['Brightpearl-Dev-Ref'] && interaction.request.headers['Brightpearl-Dev-Ref'].first
  end

  config.filter_sensitive_data('<Bearer TOKEN>') do |interaction|
    interaction.request.headers['Authorization'] && interaction.request.headers['Authorization'].first
  end
  
  # Optionally, filter the account name in the URL for consistency in cassettes
  config.filter_sensitive_data('/public-api/<ACCOUNT>/') do |interaction|
    uri = URI(interaction.request.uri)
    path_parts = uri.path.split('/')
    if path_parts.length > 2 && path_parts[1] == 'public-api'
      "/public-api/#{path_parts[2]}/"
    end
  end
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
