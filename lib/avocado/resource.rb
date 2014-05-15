module Avocado
  class Resource

    attr_accessor :name

    def self.infer(request)
      resource = new
      resource.name = infer_name_from_route(request.path, request.method)
      resource
    end

    def exists?
      name.present?
    end

    private

      def self.infer_name_from_route(path, method)
        controller = Rails.application.routes.recognize_path(path, method: method)[:controller]
        name = controller.partition('/').reject(&:blank?).last
        name.titleize.split('/').last
      rescue ActionController::RoutingError
        nil
      end

  end
end