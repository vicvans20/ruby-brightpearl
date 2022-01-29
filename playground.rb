$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'pry'
require_relative './lib/brightpearl.rb'

Brightpearl.config.api_domain =   ENV["RUBY_BRIGHTPEARL_ENDPOINT"]
Brightpearl.config.app_ref =      ENV["RUBY_BRIGHTPEARL_APP_REF"]
Brightpearl.config.dev_ref =      ENV["RUBY_BRIGHTPEARL_DEV_REF"]
Brightpearl.config.account =      ENV["RUBY_BRIGHTPEARL_ACCOUNT"]
Brightpearl.config.token =        ENV["RUBY_BRIGHTPEARL_TOKEN"] # It expires

puts "hello"

puts Brightpearl::Order.get(1)