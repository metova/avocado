module Avocado
  class Uploader
    include Singleton

    attr_accessor :payload

    def initialize
      @payload = []
    end

    def upload
      return unless should_upload?
      file = File.open "avocado+#{SecureRandom.hex}.json", 'a+:UTF-8'
      file.write JSON[payload]
      allow_external_connection do
        post! file, Avocado.upload_token
      end
    ensure
      if file
        file.close
        File.delete file.path
      end
    end

    private

      def allow_external_connection(&block)
        if defined? WebMock
          WebMock.allow_net_connect!
          yield
          WebMock.disable_net_connect!
        else
          yield
        end
      end

      def post!(file, upload_token)
        request = Net::HTTP::Post::Multipart.new uri.path, 'file' => UploadIO.new(file, 'text/json', 'avocado.json')
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: ssl?) do |http|
          http.request request
        end

        p response.code

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          raise "Avocado does not follow redirects! Update URL to point to #{response['location']}"
        else
          raise response.value
        end
      end

      def should_upload?
        payload.present? && Avocado.url.presence
      end

      def ssl?
        uri.scheme == 'https'
      end

      def uri
        @_uri ||= URI.parse Avocado.url
      rescue URI::InvalidURIError
        raise "Avocado's URL is set but is not a valid URL!"
      end

  end
end

