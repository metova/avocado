# This concern gets patched into ActionController::Base during testing
# The after_action will ensure every request gets documented regardless of the
# type of test (controller, integration, etc)
module Avocado
  module Controller
    extend ActiveSupport::Concern

    included do
      after_action -> do
        Avocado::Cache.clean
        Avocado::Cache.store(request, response) if documentable?
      end
    end

    def documentable?
      !!JSON.parse(response.body)
    rescue JSON::ParserError
      false
    end

  end
end