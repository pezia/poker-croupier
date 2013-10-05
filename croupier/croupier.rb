$:.push('lib/api')

require 'thrift'
require 'croupier'

module Croupier
  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

require_relative 'lib/croupier_handler'

processor = API::Croupier::Processor.new(Croupier::Handler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()