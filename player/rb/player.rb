
$:.push('thrift_interface')

require 'thrift'
require 'player_strategy'

require_relative 'lib/player_strategy_handler'


processor = API::PlayerStrategy::Processor.new(PlayerStrategyHandler.new())
transport = Thrift::ServerSocket.new(ARGV[1])
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()