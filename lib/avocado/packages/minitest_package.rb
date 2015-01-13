module Avocado
  module Packages
    class MinitestPackage < Package

      def description
        example
      end

      def document?
        true
      end

    end
  end
end
