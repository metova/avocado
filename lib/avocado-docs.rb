require 'avocado/uploader'
require 'avocado/controller_patch'
require 'avocado/endpoint_store'
require 'avocado/adapters/base_adapter'
require 'avocado/adapters/minitest_adapter'
require 'avocado/adapters/rspec_adapter'
require 'avocado/serializers/adapter_serializer'
require 'avocado/serializers/request_serializer'
require 'avocado/serializers/response_serializer'
require 'avocado/serializers/resource_serializer'

require 'yaml'
require 'net/http/post/multipart'

module Avocado
  class << self
    attr_accessor :url, :upload_token, :headers, :document_if, :ignored_params

    def configure
      yield self
    end

    def reset!
      self.url = 'http://localhost:3000/avocado'
      self.upload_token = ''
      self.headers = []
      self.document_if = proc { true }
      self.ignored_params = %w(controller action format)
      Avocado::EndpointStore.instance.reset!
      Avocado::Uploader.instance.payload = []
    end

  end
end

Avocado.reset!
