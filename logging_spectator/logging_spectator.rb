$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require 'spectator'
require 'logging_spectator'

module LoggingSpectator

  autoload :Handler, 'lib/handler'

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
