# This concern gets patched into ActionController::Base during testing
# The after_action will ensure every request gets documented regardless of the
# type of test (controller, integration, etc)
module Avocado
  module ControllerPatch
    def self.included(base)
      base.around_action :_avocado_store_request
    end

    def self.apply
      ActionController::Base.send :include, Avocado::ControllerPatch
    end

    def _avocado_store_request
      yield
    ensure
      Avocado.storage.store(request, response) if _avocado_response.documentable?
    end

    def _avocado_response
      @__avocado_response ||= Avocado::ControllerResponse.new response
    end
  end
end
