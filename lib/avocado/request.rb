module Avocado
  class Request

    attr_reader :request, :response, :resource
    attr_accessor :description

    def initialize(request, response)
      @request  = request
      @response = response
      @resource = Avocado::Resource.infer(request)
      @headers  = {}
      Avocado::Config.headers.each do |name|
        @headers[name] = request.headers.env[name]
      end
    end

    def to_h
      {
        description: description,
        resource: {
          name: resource.name
        },
        request: {
          type: request.method,
          url: request.path,
          params: request.params.except('controller', 'action'),
          headers: @headers.compact
        },
        response: {
          status: response.status,
          body: response.body
        }
      }
    end

  end
end