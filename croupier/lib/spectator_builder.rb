require 'spectator'

class Croupier::SpectatorBuilder

  def build_spectator(host, port)
    Croupier::Spectator.new *build_strategy(host, port)
  end

  private

  def build_strategy(host, port)
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
    protocol = Thrift::BinaryProtocol.new(transport)
    strategy = API::Spectator::Client.new(protocol)
    [strategy, transport]
  end
end