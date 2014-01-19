require 'player_strategy'

class Croupier::PlayerBuilder

  def build_player(host, port)
    Croupier::Player.new(Croupier::PlayerStrategy.new(*build_strategy(host, port)))
  end

  private

  def build_strategy(host, port)
    if port != 8080
      socket = Thrift::Socket.new(host, port)
    else
      socket = Thrift::HTTPClientTransport.new('http://localhost:8080/php/player_service.php')
    end

    transport = Thrift::BufferedTransport.new(socket)
    protocol = Thrift::BinaryProtocol.new(transport)
    strategy = API::PlayerStrategy::Client.new(protocol)
    [strategy, transport]
  end
end