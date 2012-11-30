module Avocado
  # Convenience methods to return the request/response from Rack
  # When one of them isn't present, Rack throws an exception instead of
  # just returning nil which is pretty inconvenient and uglifies the code
  # since there needs to be rescues. These methods are also accessible from
  # the host project's tests
  module World
    def request
      last_request
    rescue Rack::Test::Error
      nil
    end

    def response
      last_response
    rescue Rack::Test::Error
      nil
    end
  end
end