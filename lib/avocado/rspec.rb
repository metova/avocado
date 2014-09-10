RSpec.configure do |config|

  config.before(:suite) do
    ActionController::Base.send :include, Avocado::Controller
    ActionController::API.send  :include, Avocado::Controller if defined?(ActionController::API)
  end

  # Invoke all middleware with the request/response stored from the after_action in the controller
  # The final action is to store the request JSON in the Avocado module until after(:suite) executes
  config.after(:each) do |ex|
    _ex = defined?(example) ? example : ex
    request  = Avocado::RequestStore.instance.request
    response = Avocado::RequestStore.instance.response

    if request && response
      package = Avocado::Packages::RSpecPackage.new(_ex, request, response)
      Avocado::Middleware.invoke(package) do
        Avocado::Uploader.instance.payload << Avocado::RequestStore.instance.json
      end
    end

    Avocado::RequestStore.instance.reset!
  end

  # Upload avocado.json to the configured URL if one is given
  config.after(:suite) do
    Avocado::Uploader.instance.upload!
  end

end
