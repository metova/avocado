# Temporarily store a JSON request/response. Ultimately RSpec will determine
# if this request/response gets documented or not in an after(:each) block
module Avocado
  class Cache
    class << self

      attr_accessor :request, :response, :json

      def store(request, response)
        @json = {}
        @request, @response = request, response
      end

      def clean
        @json = @request = @response = nil
      end

    end
  end
end