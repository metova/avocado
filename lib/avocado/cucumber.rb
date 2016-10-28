Avocado::ControllerPatch.apply

After do |scenario|
  request  = Avocado.storage.request
  response = Avocado.storage.response
  adapter  = Avocado::Adapters::CucumberAdapter.new scenario, request, response

  Avocado.uploader.payload << adapter.to_h if adapter.upload?
  Avocado.storage.clear
end

at_exit do
  Avocado.uploader.upload
end
