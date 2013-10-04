$:.push('lib/api')

require 'thrift'
require 'player_strategy'
require 'croupier'

require_relative 'lib/croupier_handler'

processor = API::Croupier::Processor.new(CroupierHandler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()