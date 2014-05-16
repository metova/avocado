require 'avocado/engine'
require 'avocado/config'
require 'avocado/controller'
require 'avocado/cache'
require 'avocado/middleware'
require 'avocado/middleware/defaults'

require 'yaml'
require 'net/http/post/multipart'

module Avocado
  @payload = []

  class << self
    attr_accessor :payload
  end

  def self.upload!
    return if @payload.size.zero?
    yaml = write_payload_to_yaml_file
    WebMock.allow_net_connect!

    # read the file and upload it
    File.open('avocado.yml') do |file|
      uri = URI.parse Avocado::Config.url
      req = Net::HTTP::Post::Multipart.new uri.path, 'file' => UploadIO.new(file, 'text/yaml', 'avocado.yml')
      p Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end
    end
  rescue URI::InvalidURIError
    raise "Avocado::Config.url should point to your mounted Avocado documentation engine, it is currently not a valid URL"
  ensure
    WebMock.disable_net_connect!
  end

  def self.reset!
    self.payload = []
    Avocado::Config.reset!
    Avocado::Cache.clean
  end

  private

    def self.write_payload_to_yaml_file
      File.open('avocado.yml', 'w+') do |file|
        file.write payload.to_yaml
      end
    end

end