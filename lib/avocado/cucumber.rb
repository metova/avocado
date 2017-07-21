Avocado::ControllerPatch.apply

After do |scenario|
  request  = Avocado.cache.request
  response = Avocado.cache.response
  adapter  = Avocado::Adapters::CucumberAdapter.new scenario, request, response

  Avocado.uploader.payload << adapter.to_h if adapter.upload?
  Avocado.cache.clear
end

at_exit do
  Avocado.uploader.upload
end
