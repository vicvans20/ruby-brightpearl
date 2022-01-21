# frozen_string_literal: true

require_relative "brightpearl/version"
require_relative 'brightpearl/config'

module Brightpearl
  class Error < StandardError; end
  # Your code goes here...

  def self.config
    @config ||= Config.new
  end
  
end
