module Avocado
  class Middleware::DocumentIfConfiguration

    def call(*)
      continue = Avocado::Config.document_if.call
      yield continue
    end

  end
end