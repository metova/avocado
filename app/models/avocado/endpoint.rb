module Avocado
  class Endpoint
    include ActiveModel::Model

    attr_accessor :signature, :requests

    def initialize(*)
      @requests = SortedSet.new
      super
    end
  end
end
