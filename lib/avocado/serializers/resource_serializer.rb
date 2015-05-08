module Avocado
  module Serializers
    class ResourceSerializer

      def initialize(request)
        @request = request
      end

      def to_h
        {
          name: infer_resource_name_from_request
        }
      end

      private

        def infer_resource_name_from_request
          controller = @request.params[:controller]
          name = controller.partition('/').reject(&:blank?).last
          name.titleize.split('/').last
        end

    end
  end
end