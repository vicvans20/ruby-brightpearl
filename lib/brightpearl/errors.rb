module Brightpearl
  class RequestError < StandardError
    attr_reader :response, :code
    def initialize(msg)
      # TODO dynamically set error from request when possible
      super(msg)
      @response = response
      @code = code
    end
  end

  class Throttled < StandardError
    attr_reader :response, :code
    def initialize(msg)
      super(msg)
      @response = response
      @code = code
    end
  end
end