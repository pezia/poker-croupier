$:.push('lib/api')

require 'thrift'
require 'croupier'

require_relative 'lib/croupier_handler'

processor = API::Croupier::Processor.new(Croupier::Handler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()