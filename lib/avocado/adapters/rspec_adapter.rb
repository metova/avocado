module Avocado
  module Adapters
    class RSpecAdapter < BaseAdapter

      def description
        example.description
      end

      def valid?
        super do
          example.metadata[:document] != false
        end
      end

    end
  end
end