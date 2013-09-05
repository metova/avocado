module Avocado
  class Spec < Example

    def steps
      nil
    end

    def heading
      example.description.capitalize
    end

  end
end