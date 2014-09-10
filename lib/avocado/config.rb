module Avocado
  class Config
    class << self

      attr_accessor :url, :headers, :document_if, :json_path, :ignored_params

      def configure(&block)
        yield self
      end

      def headers
        Array(@headers) || []
      end

      def document_if
        @document_if || -> { true }
      end

      def json_path
        @json_path || Rails.application.root
      end

      def ignored_params
        @ignored_params ||= ['controller', 'action']
      end

      def reset!
        @headers = nil
        @document_if = nil
        @json_path = nil
        @ignored_params = nil
      end

    end
  end
end