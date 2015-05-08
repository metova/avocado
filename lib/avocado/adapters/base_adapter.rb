module Avocado
  module Adapters
    class BaseAdapter

      attr_accessor :example, :request, :response

      def initialize(example, request, response)
        @example = example
        @request = request
        @response = response
      end

      def description
        raise 'Implement #description'
      end

      def valid?
        _valid = request && response && document_if_proc_truthy? && !ajax?
        if block_given?
          _valid &&= !!yield
        end
        _valid
      end

      private

        def document_if_proc_truthy?
          Avocado.document_if.call request, response
        end

        def ajax?
          request.xhr?
        end

    end
  end
end