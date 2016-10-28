module Avocado
  class ControllerResponse
    def initialize(response)
      @response = response
    end

    def documentable?
      blank_204? || json?
    end

    private
      def blank_204?
        @response.status == 204 && @response.body.blank?
      end

      def json?
        JSON.parse @response.body
      rescue JSON::ParserError, TypeError
        false
      end
  end
end
