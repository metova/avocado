module Avocado
  class Middleware::IgnoreXhrRequests

    # return false and bail if the request is AJAX
    def call(package)
      yield !package.request.xhr?
    end

  end
end