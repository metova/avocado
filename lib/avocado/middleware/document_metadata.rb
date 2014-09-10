module Avocado
  class Middleware::DocumentMetadata

    # return false if the :document metadata is given and is explicitly false
    def call(package)
      if package.document?
        yield false
      else
        yield
      end
    end

  end
end