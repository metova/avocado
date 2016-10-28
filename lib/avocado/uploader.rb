require 'net/http/post/multipart'

module Avocado
  class Uploader
    include Singleton
    include Logger

    attr_accessor :payload

    def initialize
      reset
    end

    def reset
      @payload = []
    end

    def upload
      return if payload.blank? || url.blank?

      response = Net::HTTP.start(url.host, url.port, use_ssl: https?) do |http|
        http.request multipart_req
      end

      if success? response
        logger.info "Successfully uploaded to #{url}"
      else
        logger.error "Failed to upload to #{url} (response code #{response.code}). Full response:"
        logger.error response.body
      end
    end

    def url
      URI.parse Avocado.url.to_s if Avocado.url
    rescue URI::InvalidURIError
      logger.error "Could not parse the URI #{Avocado.url}--Avocado will not upload documentation!"
      nil
    end

    private
      def multipart_req
        @_multipart_req ||= Net::HTTP::Post::Multipart.new url.path, file: uploadable_file, upload_id: upload_id
      end

      def uploadable_file
        @_uploadable_file ||= begin
          file = StringIO.new JSON[payload]
          UploadIO.new file, 'application/json'
        end
      end

      def upload_id
        @_upload_id ||= Avocado.upload_id.call
      end

      def https?
        url.to_s.include? 'https://'
      end

      def success?(response)
        (200..399).cover? response.code.to_i
      end
  end
end
