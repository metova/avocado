RSpec.configure do |config|

  config.before(:suite) do
    ActionController::Base.send :include, Avocado::ControllerPatch
    ActionController::API.send  :include, Avocado::ControllerPatch if defined?(ActionController::API)
  end

  config.after(:each) do |ex|
    _example = defined?(example) ? example : ex
    request  = Avocado::EndpointStore.instance.request
    response = Avocado::EndpointStore.instance.response
    adapter  = Avocado::Adapters::RSpecAdapter.new(_example, request, response)

    if adapter.valid?
      Avocado::Uploader.instance.payload << Avocado::Serializers::AdapterSerializer.new(adapter).to_h
    end

    Avocado::EndpointStore.instance.reset!
  end

  # Upload avocado.json to the configured URL if one is given
  config.after(:suite) do
    Avocado::Uploader.instance.upload
  end

end
