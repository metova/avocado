require 'avocado'
require 'avocado/rspec/spec'
require 'rack/test'

module AvocadoHelper
  def app
    Rails.application
  end
end

RSpec.configure do |config|

  config.include AvocadoHelper
  config.include Rack::Test::Methods

  config.after(:each) do
    Avocado::Spec.new(example).store(request, response) rescue nil
  end

  config.after(:suite) do
    Avocado.document!
  end

end
