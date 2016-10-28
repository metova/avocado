module Avocado::Minitest
  def before_setup
    super
    Avocado::ControllerPatch.apply
  end

  def before_teardown
    super

    request  = Avocado.storage.request
    response = Avocado.storage.response
    adapter  = Avocado::Adapters::MinitestAdapter.new name, request, response

    Avocado.uploader.payload << adapter.to_h if adapter.upload?
    Avocado.storage.clear
  end
end

Minitest::Test.send :include, Avocado::Minitest

Minitest.after_run do
  Avocado.uploader.upload
end
