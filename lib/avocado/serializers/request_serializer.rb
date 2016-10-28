module Avocado
  module Serializers
    class RequestSerializer
      def initialize(request)
        @request = request
      end

      def to_h
        {
          method:  @request.method,
          path:    @request.path,
          params:  sanitize_params(@request.params).to_h,
          headers: headers
        }
      end

      private
        def headers
          hash = {}
          Avocado.headers.each do |name|
            hash[name] = @request.headers.env["HTTP_#{name.tr('-', '_')}".upcase]
          end
          hash.select { |_, value| !value.nil? }
        end

        def sanitize_params(params)
          params = params.except *Avocado.ignored_params.flatten
          deep_replace_file_uploads_with_text params
          params
        end

        def deep_replace_file_uploads_with_text(hash)
          hash.each do |k, v|
            if v.respond_to? :eof
              hash[k] = '<Multipart File Upload>'
            elsif v.is_a? Hash
              deep_replace_file_uploads_with_text v
            end
          end
        end
    end
  end
end
