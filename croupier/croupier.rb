$:.push(File.join(File.dirname(__FILE__), 'lib/api'))

require 'thrift'
require 'croupier'

module Croupier
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

