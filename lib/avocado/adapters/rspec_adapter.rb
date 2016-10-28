module Avocado
  module Adapters
    class RSpecAdapter < BaseAdapter
      def description
        spec.description
      end

      def upload?
        super { spec.metadata[:document] != false }
      end
    end
  end
end
