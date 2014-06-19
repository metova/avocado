module Avocado
  class Resource
    include ActiveModel::Model

    attr_accessor :name, :endpoints

    def initialize(*)
      @endpoints = Set.new
      super
    end

    def <=>(other)
      name <=> other.name
    end

  end
end