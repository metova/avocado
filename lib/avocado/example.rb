module Avocado
  class Example

    attr_accessor :example, :resource, :request, :response

    def initialize(example)
      @example = example
    end

    def store(request, response)
      @request, @response = request, response
      @resource = resource_name_from_url(request.path, request.request_method)
      Avocado.store(self) if @resource
    end

    protected

      def resource_name_from_url(path, method)
        Rails.application.routes.recognize_path(path, method: method)[:controller].
          partition('/').last.titleize.split('/').last
      rescue ActionController::RoutingError
        nil
      end

  end
end