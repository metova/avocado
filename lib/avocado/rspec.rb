require 'avocado'
require 'avocado/rspec/spec'
require 'rack/test'

RSpec.configure do |config|

  config.include Rack::Test::Methods

  config.after(:each) do
    Avocado::Spec.new(example).store(request, response)
  end

  config.after(:suite) do
    Avocado.document!
  end

end