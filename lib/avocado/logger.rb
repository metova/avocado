require 'logger'

module Avocado
  module Logger
    def logger
      @_logger ||= begin
        logger = ::Logger.new STDOUT
        logger.formatter = proc { |_, _, _, msg| "\n[Avocado] #{msg}\n" }
        logger
      end
    end
  end
end
