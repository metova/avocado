module Avocado::Minitest
  def before_setup
    super
    Avocado::ControllerPatch.apply
  end

  def before_teardown
    super

    request  = Avocado.cache.request
    response = Avocado.cache.response
    adapter  = Avocado::Adapters::MinitestAdapter.new name, request, response

    Avocado.uploader.payload << adapter.to_h if adapter.upload?
    Avocado.cache.clear
  end
end

Minitest::Test.send :include, Avocado::Minitest

Minitest.after_run do
  Avocado.uploader.upload
end
