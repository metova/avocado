module Avocado
  class Middleware

    attr_accessor :entries

    def initialize
      @entries = []
    end

    def <<(klass)
      @entries << klass
    end

    def invoke(*args, &finally)
      chain = entries.map(&:new).dup
      traversal = -> (continue = true) do
        return if !continue
        if chain.empty?
          finally.call
        else
          chain.shift.call(*args, &traversal)
        end
      end
      traversal.call
    end

    def self.configure(&block)
      @chain ||= new
      yield @chain
    end

    def self.invoke(*args, &block)
      @chain.invoke(*args, &block)
    end

  end
end