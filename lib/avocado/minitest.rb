module MinitestAvocadoPlugin
  def before_setup
    super
    ActionController::Base.send :include, Avocado::Controller
    ActionController::API.send  :include, Avocado::Controller if defined?(ActionController::API)
  end

  def before_teardown
    super
    request  = Avocado::RequestStore.instance.request
    response = Avocado::RequestStore.instance.response

    if request && response
      package = Avocado::Packages::MinitestPackage.new(name, request, response)
      Avocado::Middleware.invoke(package) do
        Avocado::Uploader.instance.payload << Avocado::RequestStore.instance.json
      end
    end

    Avocado::RequestStore.instance.reset!
  end
end

class MiniTest::Test
  include MinitestAvocadoPlugin
end

if MiniTest::Unit.respond_to? :after_run
  MiniTest::Unit.after_run do
    Avocado::Uploader.instance.upload!
  end
else
  MiniTest.after_run do
    Avocado::Uploader.instance.upload!
  end
end
