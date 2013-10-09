$:.push(File.join(File.dirname(__FILE__), '../common/lib'))

require_relative 'croupier'
require_relative 'lib/handler'

processor = API::Croupier::Processor.new(Croupier::Handler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()

