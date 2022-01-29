# frozen_string_literal: true
require 'httparty'
require 'uri'

require "brightpearl/version"
require 'brightpearl/config'
require 'brightpearl/errors'
require 'brightpearl/client'
require 'brightpearl/auth'

require 'brightpearl/api_operations'
require 'brightpearl/resources'

module Brightpearl
  class Error < StandardError; end
  # Your code goes here...

  def self.config
    @config ||= Config.new
  end
  
end
