module Avocado
  class Middleware::ResponseSerialization

    def call(package)
      response = package.response
      Avocado::RequestStore.instance.json.merge! response: serialize(response)
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