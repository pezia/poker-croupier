
$:.push('gen-rb')

require 'thrift'
require 'player'

class PlayerHandler
  def new_game
    puts "New Game"
  end
end


processor = Player::Processor.new(PlayerHandler.new())
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
server.serve()