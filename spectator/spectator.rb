
$:.push('lib/api')

require 'thrift'
require 'spectator'

require_relative 'lib/spectator_handler'

port = ARGV[1]

processor = API::Spectator::Processor.new(SpectatorHandler.new())
transport = Thrift::ServerSocket.new(port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()