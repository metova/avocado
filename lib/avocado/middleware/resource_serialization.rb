module Avocado
  class Middleware::ResourceSerialization

    def call(package)
      request = package.request
      name = infer_resource_name_from_request(request)
      Avocado::RequestStore.instance.json.merge! resource: { name: name }
      yield
    end

    private

      def infer_resource_name_from_request(request)
        controller = request.params[:controller]
        name = controller.partition('/').reject(&:blank?).last
        name.titleize.split('/').last
      end

  end
end