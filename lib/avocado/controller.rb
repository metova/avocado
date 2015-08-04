# This concern gets patched into ActionController::Base during testing
# The after_action will ensure every request gets documented regardless of the
# type of test (controller, integration, etc)
module Avocado
  module Controller
    extend ActiveSupport::Concern

    included do
      prepend_around_action :store_request_and_response_in_avocado
    end

    def documentable?
      (response.status == 204 && response.body.blank?) || !!JSON.parse(response.body)
    rescue
      false
    end

    def store_request_and_response_in_avocado
      yield
    ensure
      Avocado::RequestStore.instance.reset!
      Avocado::RequestStore.instance.store(request, response) if documentable?
    end

  end
end
