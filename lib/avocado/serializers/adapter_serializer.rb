module Avocado
  module Serializers
    class AdapterSerializer

      def initialize(adapter)
        @example  = adapter.example
        @request  = adapter.request
        @response = adapter.response
      end

      def to_h
        {
          resource: ResourceSerializer.new(@request).to_h,
          description: @example.description,
          request: RequestSerializer.new(@request).to_h,
          response: ResponseSerializer.new(@response).to_h
        }
      end

    end
  end
end