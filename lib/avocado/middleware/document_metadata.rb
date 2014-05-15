module Avocado
  class Middleware::DocumentMetadata

    # Stops the middleware chain if document: false was passed into the RSpec example
    def call(example, *)
      if example.metadata[:document] == false
        yield false
      else
        yield
      end
    end

  end
end