RSpec.configure do |config|

  config.before(:suite) do
    ActionController::Base.send :include, Avocado::Controller
    ActionController::API.send  :include, Avocado::Controller if defined?(ActionController::API)
  end

  # Invoke all middleware with the request/response stored from the after_action in the controller
  # The final action is to store the request JSON in the Avocado module until after(:suite) executes
  config.after(:each) do |ex|
    _example = defined?(example) ? example : ex
    request  = Avocado::Cache.request
    response = Avocado::Cache.response

    if request && response
      Avocado::Middleware.invoke(_example, request, response) do
        Avocado.payload << Avocado::Cache.json
      end
    end

    Avocado::Cache.clean
  end

  # Upload avocado.yml to the configured URL if one is given
  config.after(:suite) { Avocado.upload! }

end
