
$:.push('thrift_interface')

require 'thrift'
require 'player'

require_relative 'lib/player_handler'


processor = Player::Processor.new(PlayerHandler.new())
transport = Thrift::ServerSocket.new(ARGV[1])
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()