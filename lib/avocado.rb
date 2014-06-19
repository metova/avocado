require 'avocado/engine'
require 'avocado/config'
require 'avocado/uploader'
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
    return if @payload.empty?
    File.open('avocado.yml', 'w+') do |file|
      file.write payload.to_yaml
      Avocado::Uploader.new.upload(@payload, file) if Avocado::Config.url
    end
  end

  def self.reset!
    self.payload = []
    Avocado::Config.reset!
    Avocado::Cache.clean
  end

end