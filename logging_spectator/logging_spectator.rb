$:.push(File.join(File.dirname(__FILE__), 'lib/api'))
$:.push(File.join(File.dirname(__FILE__)))

require 'thrift'
require 'spectator'
require 'logger'

module LoggingSpectator

  autoload :Handler, 'lib/logging_spectator_handler'

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

require_relative 'lib/logging_spectator_handler'

port = ARGV.first

processor = API::Spectator::Processor.new(LoggingSpectator::Handler.new())
transport = Thrift::ServerSocket.new(port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()