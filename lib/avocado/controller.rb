# This concern gets patched into ActionController::Base during testing
# The after_action will ensure every request gets documented regardless of the
# type of test (controller, integration, etc)
module Avocado
  module Controller
    extend ActiveSupport::Concern

    included do
      around_action :store_request_and_response_for_avocado
    end

    def documentable?
      response.body.blank? || !!JSON.parse(response.body)
    rescue
      false
    end

    def store_request_and_response_for_avocado
      yield
    ensure
      Avocado::Cache.clean
      Avocado::Cache.store(request, response) if documentable?
    end

  end
end