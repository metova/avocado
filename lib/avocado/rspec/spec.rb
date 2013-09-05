module Avocado
  class Spec < Example

    def heading
      example.description.capitalize
    end

    def steps
      nil
    end

  end
end