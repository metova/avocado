module Avocado
  module Adapters
    class CucumberAdapter < BaseAdapter
      def description
        spec.name
      end

      def upload?
        super do
          spec.tags.none? { |tag| tag.name == 'nodoc' }
        end
      end
    end
  end
end
