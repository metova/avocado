RSpec.configure do |config|
  config.before(:suite) do
    Avocado::ControllerPatch.apply
  end

  config.after(:each) do |ex|
    # Older versions of RSpec use the global `example` object
    spec = defined?(example) ? example : ex

    request  = Avocado.cache.request
    response = Avocado.cache.response
    adapter  = Avocado::Adapters::RSpecAdapter.new spec, request, response

    Avocado.uploader.payload << adapter.to_h if adapter.upload?
    Avocado.cache.clear
  end

  config.after(:suite) do
    Avocado.uploader.upload
  end
end
