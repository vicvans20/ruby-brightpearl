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

  config.filter_sensitive_data('<APP-REF>') do |interaction|
    interaction.request.headers['Brightpearl-App-Ref'].first
  end

  config.filter_sensitive_data('<DEV-REF>') do |interaction|
    interaction.request.headers['Brightpearl-Dev-Ref'].first
  end

  config.filter_sensitive_data('<Bearer TOKEN>') do |interaction|
    interaction.request.headers['Authorization'].first
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

  config.before(:suite) do
    Brightpearl.config.api_domain = ENV["RUBY_BRIGHTPEARL_ENDPOINT"]
    Brightpearl.config.app_ref =      ENV["RUBY_BRIGHTPEARL_APP_REF"]
    Brightpearl.config.dev_ref =      ENV["RUBY_BRIGHTPEARL_DEV_REF"]
    Brightpearl.config.account =      ENV["RUBY_BRIGHTPEARL_ACCOUNT"]
  end
  
  config.before(:each) do
    Brightpearl.config.token =        ENV["RUBY_BRIGHTPEARL_TOKEN"] # It expires
  end
end
