# Temporarily store a JSON request/response. Ultimately RSpec will determine
# if this request/response gets documented or not in an after(:each) block
module Avocado
  class EndpointStore
    include Singleton

    attr_accessor :request, :response

    def store(request, response)
      @request = request
      @response = response
    end

    def reset!
      @request = nil
      @response = nil
    end

  end
end