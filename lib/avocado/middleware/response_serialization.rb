module Avocado
  class Middleware::ResponseSerialization

    def call(example, request, response)
      Avocado::Cache.json.merge! response: serialize(response)
      yield
    end

    private

      def serialize(response)
        {
          status: response.status,
          body:   response.body
        }
      end

  end
end