# frozen_string_literal: true

require_relative "brightpearl/version"
require_relative 'brightpearl/config'
require_relative 'brightpearl/client'
require_relative 'brightpearl/resources/order'

require 'httparty'
require 'uri'

module Brightpearl
  class Error < StandardError; end
  # Your code goes here...

  def self.config
    @config ||= Config.new
  end
  
end
