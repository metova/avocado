module Avocado
  class Uploader

    attr_reader :payload

    def upload(payload)
      @payload = payload
      return if Avocado::Config.url.nil?
      yaml = write_documentation
      File.open('avocado.yml') { |file| upload! file }
      File.delete 'avocado.yml'
    end

    private

      def write_documentation
        File.open('avocado.yml', 'w+') do |file|
          file.write payload.to_yaml
        end
      end

      def upload!(file)
        WebMock.allow_net_connect!
        uri = URI.parse Avocado::Config.url
        req = Net::HTTP::Post::Multipart.new uri.path, 'file' => UploadIO.new(file, 'text/yaml', 'avocado.yml')
        response = Net::HTTP.start(uri.host, uri.port) do |http|
          http.request(req)
        end
      ensure
        WebMock.disable_net_connect!
      end

      def uri
        @uri ||= URI.parse Avocado::Config.url
      rescue URI::InvalidURIError
        raise "Avocado::Config.url is set but is not a valid URL!"
      end

  end
end

