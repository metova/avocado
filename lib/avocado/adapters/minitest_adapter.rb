module Avocado
  module Adapters
    class MinitestAdapter < BaseAdapter

      def description
        example
      end

      def document?
        true
      end

    end
  end
end
