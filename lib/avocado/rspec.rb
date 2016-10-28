RSpec.configure do |config|
  config.before(:suite) do
    Avocado::ControllerPatch.apply
  end

  config.after(:each) do |ex|
    # Older versions of RSpec use the global `example` object
    spec = defined?(example) ? example : ex

    request  = Avocado.storage.request
    response = Avocado.storage.response
    adapter  = Avocado::Adapters::RSpecAdapter.new spec, request, response

    Avocado.uploader.payload << adapter.to_h if adapter.upload?
    Avocado.storage.clear
  end

  config.after(:suite) do
    Avocado.uploader.upload
  end
end
