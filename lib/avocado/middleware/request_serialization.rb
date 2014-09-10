module Avocado
  class Middleware::RequestSerialization

    def call(package)
      @request = package.request
      Avocado::RequestStore.instance.json.merge! request: serialize(@request)
      yield
    end

    private

      def serialize(request)
        {
          method:  request.method,
          path:    request.path,
          params:  sanitize_params(request.params).to_h,
          headers: headers
        }
      end

      def headers
        hash = {}
        Avocado::Config.headers.each do |name|
          hash[name] = @request.headers.env["HTTP_#{name.tr('-', '_')}".upcase]
        end
        hash.select { |_, value| !value.nil? }
      end

      def sanitize_params(params)
        params = params.except(*Avocado::Config.ignored_params.flatten)
        deep_replace_file_uploads_with_text(params)
        params
      end

      def deep_replace_file_uploads_with_text(hash)
        hash.each do |k, v|
          case v
          when Hash
            deep_replace_file_uploads_with_text(v)
          when Rack::Test::UploadedFile
            hash[k] = '<Multipart File Upload>'
          end
        end
      end

  end
end