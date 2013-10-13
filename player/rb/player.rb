
$:.push('lib/api')

require 'thrift'
require 'player_strategy'

require_relative 'lib/player_strategy_handler'

port = ARGV[1]

processor = API::PlayerStrategy::Processor.new(PlayerStrategyHandler.new())
transport = Thrift::ServerSocket.new(port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::SimpleServer.new(processor, transport, transportFactory)
server.serve()