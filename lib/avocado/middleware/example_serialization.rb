module Avocado
  class Middleware::ExampleSerialization

    def call(package)
      Avocado::RequestStore.instance.json[:description] = package.description
      yield
    end

  end
end