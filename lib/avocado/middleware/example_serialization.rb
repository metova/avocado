module Avocado
  class Middleware::ExampleSerialization

    def call(*)
      Avocado::Cache.json[:description] = RSpec.current_example.description
      yield
    end

  end
end