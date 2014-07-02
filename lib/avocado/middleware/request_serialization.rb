module Avocado
  class Middleware::RequestSerialization

    def call(example, request, response)
      @request = request
      Avocado::Cache.json.merge! request: serialize(@request)
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
          if Hash === v
            deep_replace_file_uploads_with_text(v)
          else
            hash[k] = '<Multipart File Upload>' if v.respond_to? :path
          end
        end
      end

  end
end