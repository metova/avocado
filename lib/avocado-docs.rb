require 'avocado/engine'
require 'avocado/controller_patch'
require 'avocado/controller_response'
require 'avocado/logger'
require 'avocado/cache'
require 'avocado/uploader'
require 'avocado/storage/file'

require 'avocado/adapters/base_adapter'
require 'avocado/adapters/minitest_adapter'
require 'avocado/adapters/rspec_adapter'
require 'avocado/adapters/cucumber_adapter'

require 'avocado/serializers/request_serializer'
require 'avocado/serializers/resource_serializer'
require 'avocado/serializers/response_serializer'

module Avocado
  class << self
    attr_accessor :url, :headers, :upload_id, :document_if, :ignored_params, :cache, :uploader, :storage

    def configure
      yield self
    end

    def reset!
      self.url = nil
      self.headers = []
      self.upload_id = proc { SecureRandom.uuid }
      self.document_if = proc { true }
      self.ignored_params = %w(controller action format)
      self.cache = Avocado::Cache.instance
      self.uploader = Avocado::Uploader.instance
      self.storage = Avocado::Storage::File.new ::Rails.root

      cache.clear
      uploader.reset
    end
  end
end

Avocado.reset!
