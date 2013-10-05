require 'player_strategy'


class Croupier::PlayerBuilder
  def build_strategy(host, port)
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
    protocol = Thrift::BinaryProtocol.new(transport)
    strategy = API::PlayerStrategy::Client.new(protocol)
    transport.open()
    log.info "Connected #{strategy.name()} at #{host}:#{port}"
    strategy
  end
end