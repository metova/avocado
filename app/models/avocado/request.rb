module Avocado
  class Request
    include ActiveModel::Model

      attr_accessor :uid, :url, :path, :params, :status, :body, :headers
      attr_accessor :endpoint, :description

      def initialize(*)
        super
        self.uid = SecureRandom.hex
      end

      def ==(other)
        other.path  == path &&
        other.params == params &&
        other.status == status &&
        other.body == body
      end

      def <=>(other)
        status <=> other.status
      end

      def unique?(requests)
        requests.none? { |req| self == req }
      end

      def params
        @params || {}
      end

      def body
        @body || {}
      end

  end
end