module Avocado
  class Middleware::DocumentMetadata

    # return false if the :document metadata is given and is explicitly false
    def call(*)
      if RSpec.current_example.metadata[:document] == false
        yield false
      else
        yield
      end
    end

  end
end