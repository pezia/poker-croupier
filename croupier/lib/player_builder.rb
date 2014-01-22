require 'player_strategy'

class Croupier::PlayerBuilder

  def build_player(address)
    Croupier::Player.new(Croupier::PlayerStrategy.new(*build_strategy(address)))
  end

  private

  def build_strategy(address)

    if /^[\w\d\.]+:\d+$/ =~ address
      host, port = address.split(':')
      socket = Thrift::Socket.new(host, port)
    else
      socket = Thrift::HTTPClientTransport.new(address)
    end

    transport = Thrift::BufferedTransport.new(socket)
    protocol = Thrift::BinaryProtocol.new(transport)
    strategy = API::PlayerStrategy::Client.new(protocol)
    [strategy, transport]
  end
end