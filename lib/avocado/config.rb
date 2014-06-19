module Avocado
  class Config
    class << self

      attr_accessor :url, :headers, :document_if, :yaml_path

      def configure(&block)
        yield self
      end

      def headers
        Array(@headers) || []
      end

      def document_if
        @document_if || -> { true }
      end

      def yaml_path
        @yaml_path || Rails.application.root
      end

      def reset!
        @headers, @document_if = nil, nil
      end

    end
  end
end