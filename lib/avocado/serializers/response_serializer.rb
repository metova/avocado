module Avocado
  module Serializers
    class ResponseSerializer

      def initialize(response)
        @response = response
      end

      def to_h
        {
          status: @response.status,
          body:   @response.body
        }
      end

    end
  end
end