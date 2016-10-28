require 'avocado/engine'
require 'avocado/controller_patch'
require 'avocado/controller_response'
require 'avocado/logger'
require 'avocado/storage'
require 'avocado/uploader'
require 'avocado/adapters/base_adapter'
require 'avocado/adapters/minitest_adapter'
require 'avocado/adapters/rspec_adapter'
require 'avocado/adapters/cucumber_adapter'
require 'avocado/serializers/request_serializer'
require 'avocado/serializers/resource_serializer'
require 'avocado/serializers/response_serializer'

module Avocado
  class << self
    attr_accessor :url, :headers, :json_path, :upload_id, :document_if, :ignored_params, :storage, :uploader

    def configure
      yield self
    end

    def reset!
      self.url = nil
      self.headers = []
      self.json_path = ::Rails.root
      self.upload_id = proc { SecureRandom.uuid }
      self.document_if = proc { true }
      self.ignored_params = %w(controller action format)
      self.storage = Avocado::Storage.instance
      self.uploader = Avocado::Uploader.instance

      storage.clear
      uploader.reset
    end
  end
end

Avocado.reset!
