module Avocado
  module Adapters
    class MinitestAdapter < BaseAdapter
      # In Minitest case, the spec object is just the name of the spec
      def description
        spec
      end
    end
  end
end
