module Avocado
  class Uploader

    def upload(filename)
      WebMock.allow_net_connect!
      uri  = URI.parse Avocado::Config.url
      file = File.open(filename)
      req  = Net::HTTP::Post::Multipart.new uri.path,
              'file' => UploadIO.new(file, 'text/yaml', 'avocado.yml')

      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end
    ensure
      WebMock.disable_net_connect!
      file.close
      File.delete file.path
    end

    private

      def uri
        @uri ||= URI.parse Avocado::Config.url
      rescue URI::InvalidURIError
        raise "Avocado::Config.url is set but is not a valid URL!"
      end

  end
end

