
class ThriftBuilder
  def self.server(processor, handler, port)
    processor = processor.new(handler.new())
    transport = Thrift::ServerSocket.new('localhost', port)
    Thrift::ThreadPoolServer.new(processor, transport)
  end
end