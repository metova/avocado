module Avocado
  module Packages
    class RSpecPackage < Package

      def description
        example.description
      end

      def document?
        example.metadata[:document] != false
      end

    end
  end
end