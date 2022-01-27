module Brightpearl
  class RequestError < StandardError
    attr_reader :response, :code, :status
    def initialize(msg, response: nil, status: nil)
      if response["errors"] && response["errors"].size == 1 # If error is easily identifiable then set it as the Error message
        error = response["errors"][0]["message"]
        @code = response["errors"][0]["code"]
        super(error)
      else
        super(msg)
      end
      puts @code
      puts error
      @response = response
      @status = status
    end
  end

  class Throttled < StandardError
    attr_reader :response, :code, :status
    def initialize(msg, response: nil, status: nil)
      super(msg)
      @response = response
      @status = status
    end
  end
  
  class InvalidToken < StandardError
    attr_reader :response, :status
    def initialize(msg, response: nil, status: nil)
      super(msg)
      @response = response
      @status = status
    end
  end
end