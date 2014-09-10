module Avocado
  module Packages
    class Package

      attr_accessor :example, :request, :response

      def initialize(example, request, response)
        @example = example
        @request = request
        @response = response
      end

      def description
        raise 'Implement #description'
      end

      def document?
        raise 'Implement #document?'
      end

    end
  end
end