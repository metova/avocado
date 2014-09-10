# Temporarily store a JSON request/response. Ultimately RSpec will determine
# if this request/response gets documented or not in an after(:each) block
module Avocado
  class RequestStore
    include Singleton

    attr_accessor :request, :response, :json

    def store(request, response)
      @json = {}
      @request = request
      @response = response
    end

    def reset!
      @json = nil
      @request = nil
      @response = nil
    end

  end
end