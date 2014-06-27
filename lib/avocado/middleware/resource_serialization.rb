module Avocado
  class Middleware::ResourceSerialization

    def call(request, response)
      Avocado::Cache.json.merge! resource: { name: infer_name_from_route(request.path, request.method) }
      yield
    end

    private

      def infer_name_from_route(path, method)
        controller = Rails.application.routes.recognize_path(path, method: method)[:controller]
        name = controller.partition('/').reject(&:blank?).last
        name.titleize.split('/').last
      rescue ActionController::RoutingError
        nil
      end

  end
end