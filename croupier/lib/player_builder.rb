require_relative 'player'
require 'player_strategy'


class Croupier::PlayerBuilder
  def build_strategy(host, port)
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
    protocol = Thrift::BinaryProtocol.new(transport)
    strategy = API::PlayerStrategy::Client.new(protocol)
    transport.open()
    strategy
  end

  def build_player(host, port)
    Croupier::Player.new build_strategy(host, port)
  end
end