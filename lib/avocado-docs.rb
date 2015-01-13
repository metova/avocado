require 'avocado/engine'
require 'avocado/config'
require 'avocado/uploader'
require 'avocado/controller'
require 'avocado/request_store'
require 'avocado/packages/package'
require 'avocado/packages/minitest_package'
require 'avocado/packages/rspec_package'
require 'avocado/middleware'
require 'avocado/middleware/defaults'

require 'yaml'
require 'net/http/post/multipart'

module Avocado
  def self.reset!
    Avocado::Config.reset!
    Avocado::RequestStore.instance.reset!
    Avocado::Uploader.instance.payload = []
  end
end
