module Avocado
  class Middleware::DocumentIfConfiguration

    # return false if document_if returns false, so it will
    # stop the middleware chain and not upload anything
    def call(*)
      continue = Avocado::Config.document_if.call
      yield continue
    end

  end
end