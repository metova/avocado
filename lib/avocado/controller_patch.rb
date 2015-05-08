# This concern gets patched into ActionController::Base during testing
# The after_action will ensure every request gets documented regardless of the
# type of test (controller, integration, etc)
module Avocado
  module ControllerPatch
    extend ActiveSupport::Concern

    included do
      around_action :_store_request
    end

    def _documentable?
      (response.status == 204 && response.body.blank?) || !!JSON.parse(response.body)
    rescue
      false
    end

    def _store_request
      yield
    ensure
      Avocado::EndpointStore.instance.store(request, response) if _documentable?
    end

  end
end