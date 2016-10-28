module Avocado
  module Serializers
    class ResponseSerializer
      def initialize(response)
        @response = response
      end

      def to_h
        {
          body: @response.body,
          status: @response.status
        }
      end
    end
  end
end
