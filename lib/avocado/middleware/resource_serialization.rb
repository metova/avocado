module Avocado
  class Middleware::ResourceSerialization

    def call(example, request, response)
      name = infer_name_from_route(request.path, request.method) || ""
      Avocado::Cache.json.merge! resource: { name: name }
      yield
    end

    private

      def infer_name_from_route(path, method)
        controller = Rails.application.routes.recognize_path(path, method: method)[:controller]
        name = controller.partition('/').reject(&:blank?).last
        name.titleize.split('/').last
      rescue ActionController::RoutingError
        puts "Path #{path} not found in controller routes; Defaulting name to path."
        path
      end

  end
end