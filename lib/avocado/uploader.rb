module Avocado
  class Uploader
    include Singleton

    attr_accessor :payload

    def initialize
      @payload = []
    end

    def upload!
      return unless should_upload?
      WebMock.allow_net_connect! if defined? WebMock
      write_payload_to_json_file do |file|
        request = Net::HTTP::Post::Multipart.new uri.path, 'file' => UploadIO.new(file, 'text/json', 'avocado.json')
        net_request = Net::HTTP.new(uri.host, uri.port)
        net_request.use_ssl = (uri.scheme == 'https')
        net_request.start { |http| http.request(request) }
      end
    ensure
      WebMock.disable_net_connect! if defined? WebMock
    end

    private

      def write_payload_to_json_file(&block)
        File.write 'avocado.json', JSON[payload]
        file = File.open 'avocado.json'
        yield(file)
      ensure
        file.close
        # File.delete file.path
      end

      def should_upload?
        payload.present? && Avocado::Config.url.presence
      end

      def uri
        @_uri ||= URI.parse Avocado::Config.url
      rescue URI::InvalidURIError
        raise "Avocado::Config.url is set but is not a valid URL!"
      end

  end
end

