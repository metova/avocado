module Avocado
  class Middleware::ExampleSerialization

    def call(example, *)
      Avocado::Cache.json[:description] = example.description
      yield
    end

  end
end