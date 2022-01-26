# frozen_string_literal: true

require_relative "brightpearl/version"
require_relative 'brightpearl/config'
require_relative 'brightpearl/errors'
require_relative 'brightpearl/client'
require_relative 'brightpearl/resource'
require_relative 'brightpearl/resources/order'
require_relative 'brightpearl/resources/order_row'

require 'httparty'
require 'uri'

module Brightpearl
  class Error < StandardError; end
  # Your code goes here...

  def self.config
    @config ||= Config.new
  end
  
end
