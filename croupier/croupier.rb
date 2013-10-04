$:.push('thrift_interface')

require 'thrift'
require 'player_strategy'
require 'croupier'

require_relative 'lib/croupier_handler'

processor = Croupier::Processor.new(CroupierHandler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()