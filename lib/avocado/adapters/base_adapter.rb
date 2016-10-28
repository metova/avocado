module Avocado
  module Adapters
    class BaseAdapter
      attr_accessor :spec, :request, :response

      def initialize(spec, request, response)
        @spec = spec
        @request = request
        @response = response
      end

      def upload?(&block)
        block ||= proc { true }
        request && response && !ajax? && document_if? && block.call
      end

      def to_h
        {
          description: spec.description,
          resource: Avocado::Serializers::ResourceSerializer.new(request).to_h,
          request: Avocado::Serializers::RequestSerializer.new(request).to_h,
          response: Avocado::Serializers::ResponseSerializer.new(response).to_h
        }
      end

      private
        def ajax?
          request.xhr?
        end

        def document_if?
          Avocado.document_if.call request, response
        end
    end
  end
end
